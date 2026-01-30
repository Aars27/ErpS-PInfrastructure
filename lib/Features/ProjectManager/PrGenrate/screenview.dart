import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../Core/Storage/local_storage.dart';
import '../MaterialScreen/MaterialController.dart';
import '../MaterialScreen/MaterialModal.dart';
import 'Modal.dart';
import 'PrController.dart';



class CreatePRScreen extends StatefulWidget {
  final int projectId;

  const CreatePRScreen({super.key, required this.projectId});

  @override
  State<CreatePRScreen> createState() => _CreatePRScreenState();
}

class _CreatePRScreenState extends State<CreatePRScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _prCodeController = TextEditingController( );
  final TextEditingController _remarksController = TextEditingController();

  String prType = 'NONE';
  String urgency = 'HIGH';

  List<PRMaterialForm> materialForms = [PRMaterialForm()];

  /// MVC CONTROLLERS
  final PRController _prController = PRController();
  final MaterialController _materialController = MaterialController();

  /// MATERIAL STATE
  List<MaterialItem> materials = [];
  bool isLoadingMaterials = true;

  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  /// LOAD MATERIALS (MVC)
  void _loadMaterials() async {
    try {
      materials = await _materialController.fetchMaterials();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoadingMaterials = false);
    }
  }

  /// SUBMIT PR
  void _submitPR() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = await LocalStorage.getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final pr = PurchaseRequisition(
      projectId: widget.projectId,
      prCode: _prCodeController.text,
      prType: prType,
      urgency: urgency,
      remarks: _remarksController.text,
      materials: materialForms,
      userId: userId,
    );

    final requestBody = pr.toJson();

    /// 🔹 PRINT REQUEST BODY
    debugPrint(
      'CREATE PR REQUEST BODY:\n${const JsonEncoder.withIndent('  ').convert(requestBody)}',
    );

    try {
      final response = await _prController.submitPR(pr);

      /// 🔹 PRINT FULL BACKEND RESPONSE
      debugPrint(
        'CREATE PR BACKEND RESPONSE:\n'
            '${const JsonEncoder.withIndent('  ').convert(response)}',
      );

      /// 🔹 READ BACKEND MESSAGE
      final backendMessage =
          response['message'] ?? 'Request completed successfully';

      /// 🔹 SHOW BACKEND MESSAGE
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(backendMessage)),
      );

      if (response['status'] == 201 || response['status'] == 200) {
        Navigator.pop(context);
      }
    } catch (e) {
      /// 🔴 ERROR CASE
      debugPrint('CREATE PR ERROR: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Color _getUrgencyColor() {
    switch (urgency) {
      case 'HIGH':
        return Colors.red.shade400;
      case 'MEDIUM':
        return Colors.orange.shade400;
      case 'LOW':
        return Colors.green.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF15716),
        foregroundColor: Colors.white,
        title: const Text('Create Purchase Requisition'),
      ),
      body: isLoadingMaterials
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildPRDetails(),
            const SizedBox(height: 24),
            _buildMaterialSection(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  /// ---------------- MATERIAL SECTION ----------------

  Widget _buildMaterialSection() {
    return _buildSectionCard(
      icon: Icons.inventory_2_outlined,
      title: 'Material Items',
      children: [
        ..._buildMaterialForms(),
        const SizedBox(height: 16),
        _buildAddMaterialButton(),
      ],
    );
  }

  List<Widget> _buildMaterialForms() {
    return List.generate(materialForms.length, (index) {
      final item = materialForms[index];

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            DropdownButtonFormField<MaterialItem>(
              value: item.material,
              hint: const Text('Select Material'),
              items: materials
                  .map((m) => DropdownMenuItem(
                value: m,
                child: Text('${m.name} (${m.unit})'),
              ))
                  .toList(),
              onChanged: (v) => setState(() => item.material = v),
              validator: (v) =>
              v == null ? 'Please select a material' : null,
            ),


            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (v) => item.quantity = v,
              validator: (v) =>
              v == null || v.isEmpty ? 'Quantity required' : null,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => item.requiredDate = date);
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(item.requiredDate == null
                      ? 'Select Date'
                      : item.requiredDate!
                      .toLocal()
                      .toString()
                      .split(' ')[0]),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// ---------------- UI HELPERS ----------------

  Widget _buildPRDetails() {
    return _buildSectionCard(
      icon: Icons.description,
      title: 'PR Details',
      children: [

        TextFormField(
          maxLength: 10,
          controller: _prCodeController,
          // readOnly: true,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            labelText: 'PR Code',
            prefixIcon: const Icon(
              Icons.qr_code_2,
              color: Color(0xFFF15716),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFFF15716), width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),

        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: prType,
          items: const ['NONE', 'INVENTORY', 'PROCUREMENT']
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChanged: (v) => setState(() => prType = v!),
          decoration: const InputDecoration(labelText: 'PR Type'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField(
          value: urgency,
          items: ['LOW', 'MEDIUM', 'HIGH']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => urgency = v.toString()),
          decoration: const InputDecoration(labelText: 'Urgency'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _remarksController,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Remarks'),
        ),
      ],
    );
  }

  Widget _buildAddMaterialButton() {
    return ElevatedButton.icon(
      onPressed: () =>
          setState(() => materialForms.add(PRMaterialForm())),
      icon: const Icon(Icons.add),
      label: const Text('Add Material'),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitPR,
      child: const Text('Submit PR'),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(title,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
