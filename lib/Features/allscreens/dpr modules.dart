import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ProjectManager/DPR/DprModule.dart';
import '../ProjectManager/DPR/LabourController.dart';
import '../ProjectManager/DPR/LabourModal.dart';
import '../ProjectManager/DPR/dpr_controller.dart';
import '../ProjectManager/MaterialScreen/MaterialController.dart';
import '../ProjectManager/MaterialScreen/MaterialModal.dart';

class CreateDPRScreen extends StatefulWidget {
  final int projectId;
  final int userId;

  const CreateDPRScreen({
    super.key,
    required this.projectId,
    required this.userId,
  });

  @override
  State<CreateDPRScreen> createState() => _CreateDPRScreenState();
}

class _CreateDPRScreenState extends State<CreateDPRScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateCtrl = TextEditingController();
  final _weatherCtrl = TextEditingController();
  final _safetyCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();

  final _materialController = MaterialController();
  final _labourController = LabourController();
  final _dprController = DPRController();

  bool isLoading = true;
  bool isSubmitting = false;

  List<MaterialItem> materials = [];
  List<LabourItem> labours = [];

  List<DPRMaterial> dprMaterials = [DPRMaterial()];
  List<DPRLabourConsumption> dprLabours = [DPRLabourConsumption()];
  List<DPRMachinery> dprMachinery = [DPRMachinery()];

  @override
  void initState() {
    super.initState();
    _dateCtrl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final res = await Future.wait([
        _materialController.fetchMaterials(),
        _labourController.fetchLabours(),
      ]);
      materials = res[0] as List<MaterialItem>;
      labours = res[1] as List<LabourItem>;
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ---------------- COST ----------------
  double get materialCost =>
      dprMaterials.fold(0, (s, e) => s + (double.tryParse(e.amount ?? '0') ?? 0));

  double get labourCost =>
      dprLabours.fold(0, (s, e) => s + (double.tryParse(e.charges ?? '0') ?? 0));

  double get machineryCost => dprMachinery.fold(
      0, (s, e) => s + (double.tryParse(e.fuelAmount ?? '0') ?? 0));

  // ---------------- SUBMIT ----------------
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      final dpr = DPRModel(
        date: _dateCtrl.text,
        projectId: widget.projectId,
        weatherConditions: _weatherCtrl.text,
        safetyIncidents: _safetyCtrl.text,
        remarks: _remarksCtrl.text,
        submittedBy: widget.userId,
        materialCost: materialCost,
        labourCost: labourCost,
        machineryCost: machineryCost,
        totalCost: materialCost + labourCost + machineryCost,
        materials: dprMaterials,
        labourConsumptions: dprLabours,
        machinery: dprMachinery,
        fileIds: [],
      );

      await _dprController.createDPR(dpr);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('DPR Created Successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Create DPR'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _card('Basic Details', [
              _text(_dateCtrl, 'Date', readOnly: true),
              _text(_weatherCtrl, 'Weather', req: true),
              _text(_safetyCtrl, 'Safety', req: true),
              _text(_remarksCtrl, 'Remarks'),
            ]),
            _card('Materials', _materialForms()),
            _addBtn(() => setState(() => dprMaterials.add(DPRMaterial()))),
            _card('Labour', _labourForms()),
            _addBtn(() => setState(
                    () => dprLabours.add(DPRLabourConsumption()))),
            _summary(),
            ElevatedButton(
              onPressed: isSubmitting ? null : _submit,
              child: isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Submit DPR'),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------
  Widget _card(String title, List<Widget> children) => Card(
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    ),
  );

  Widget _text(TextEditingController c, String l,
      {bool req = false, bool readOnly = false}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: c,
          readOnly: readOnly,
          validator: req ? (v) => v!.isEmpty ? 'Required' : null : null,
          decoration: InputDecoration(labelText: l),
        ),
      );

  List<Widget> _materialForms() => dprMaterials.map((item) {
    return Column(children: [

      DropdownButtonFormField<MaterialItem>(
        value: materials.any((m) => m.id == item.material?.id)
            ? item.material
            : null,
        hint: const Text('Select Material'),
        items: materials.map((m) {
          return DropdownMenuItem(
            value: m,
            child: Text('${m.name} (${m.unit})'),
          );
        }).toList(),
        onChanged: (v) => setState(() => item.material = v),
      ),

      const SizedBox(height: 8),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Quantity'),
        keyboardType: TextInputType.number,
        onChanged: (v) {
          item.quantity = v;
          _calc(item);
        },
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Rate'),
        keyboardType: TextInputType.number,
        onChanged: (v) {
          item.rate = v;
          _calc(item);
        },
      ),
      Text('Amount: ₹${item.amount ?? "0"}'),
      const Divider(),
    ]);
  }).toList();

  void _calc(DPRMaterial m) {
    final q = double.tryParse(m.quantity ?? '0') ?? 0;
    final r = double.tryParse(m.rate ?? '0') ?? 0;
    setState(() => m.amount = (q * r).toStringAsFixed(2));
  }

  List<Widget> _labourForms() => dprLabours.map((item) {
    return Column(children: [

      DropdownButtonFormField<LabourItem>(
        value: labours.any((l) => l.id == item.labour?.id)
            ? item.labour
            : null,
        hint: const Text('Select Labour'),
        items: labours.map((l) {
          return DropdownMenuItem(
            value: l,
            child: Text(l.name),
          );
        }).toList(),
        onChanged: (v) => setState(() => item.labour = v),
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Hours'),
        keyboardType: TextInputType.number,
        onChanged: (v) => item.hours = v,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Charges'),
        keyboardType: TextInputType.number,
        onChanged: (v) => item.charges = v,
      ),
      const Divider(),
    ]);
  }).toList();

  Widget _addBtn(VoidCallback onTap) =>
      TextButton.icon(onPressed: onTap, icon: const Icon(Icons.add), label: const Text('Add'));

  Widget _summary() => Card(
    color: Colors.deepOrange,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _row('Material', materialCost),
        _row('Labour', labourCost),
        _row('Machinery', machineryCost),
        const Divider(color: Colors.white),
        _row('Total', materialCost + labourCost + machineryCost,
            bold: true),
      ]),
    ),
  );

  Widget _row(String l, double v, {bool bold = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(l,
          style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      Text('₹${v.toStringAsFixed(2)}',
          style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
    ],
  );
}
