import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smp_erp/Features/ProjectManager/DPR/File_upload_controller.dart';
import 'dart:io';

import 'DprModule.dart';
import 'LabourScreen/LabourController.dart';
import 'LabourScreen/LabourModal.dart';
import 'dpr_controller.dart';
import '../MaterialScreen/MaterialController.dart';
import '../../../Core/Storage/local_storage.dart';
import '../MaterialScreen/NewMaterialModal.dart';

class CreateDPRScreen extends StatefulWidget {
  final int projectId;

  const CreateDPRScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<CreateDPRScreen> createState() => _CreateDPRScreenState();
}

class _CreateDPRScreenState extends State<CreateDPRScreen> {
  final _formKey = GlobalKey<FormState>();
  final DPRController _dprController = DPRController();
  final MaterialController _materialController = MaterialController();
  final LabourController _labourController = LabourController();
  final FileUploadService _fileUploadService = FileUploadService();
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weatherController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();
  final TextEditingController _safetyController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  // Data
  List<MaterialItem> materials = [];
  List<LabourItem> labours = [];
  List<DPRMaterial> dprMaterials = [];
  List<DPRLabourConsumption> dprLabours = [DPRLabourConsumption()];
  List<DPRMachinery> dprMachinery = [DPRMachinery()];

  List<XFile> selectedFiles = [];
  List<int> uploadedFileIds = [];

  bool isLoading = true;
  bool isSubmitting = false;
  int? userId;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedDate = DateTime.now();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUserId();
    await _fetchData();
  }

  Future<void> _loadUserId() async {
    userId = await LocalStorage.getUserId();
    print(' User ID: $userId');
  }

  Future<void> _fetchData() async {
    try {
      final results = await Future.wait([
        _materialController.fetchMaterials(),
        _labourController.fetchLabours(),
      ]);

      setState(() {
        materials = results[0] as List<MaterialItem>;
        labours = results[1] as List<LabourItem>;
        isLoading = false;
      });

      print(' Materials: ${materials.length}');
      print(' Labours: ${labours.length}');
    } catch (e) {
      setState(() => isLoading = false);
      _showError('Failed to load data: $e');
    }
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() => selectedFiles.addAll(images));
      _showSuccess('${images.length} images selected');
    }
  }

  Future<void> _uploadFiles() async {
    if (selectedFiles.isEmpty) return;

    try {
      uploadedFileIds = await _fileUploadService.uploadFiles(selectedFiles);
      print('Uploaded file IDs: $uploadedFileIds');
      _showSuccess('${uploadedFileIds.length} files uploaded');
    } catch (e) {
      print(' Upload error: $e');
      _showError('File upload failed: $e');
    }
  }

  double _getMaterialCost() => dprMaterials.fold(
      0, (sum, m) => sum + (double.tryParse(m.amount) ?? 0));

  double _getLabourCost() => dprLabours.fold(
      0, (sum, l) => sum + (double.tryParse(l.charges) ?? 0));

  double _getMachineryCost() => dprMachinery.fold(
      0,
          (sum, m) =>
      sum +
          (double.tryParse(
              m.fuelAmount.replaceAll('₹', '').replaceAll(',', '')) ??
              0));

  void _calculateAmount(DPRMaterial item) {
    final qty = double.tryParse(item.quantity) ?? 0;
    final rate = double.tryParse(item.rate) ?? 0;

    if (qty <= 0 || rate <= 0) {
      item.amount = '0';
      return;
    }

    setState(() {
      item.amount = (qty * rate).toStringAsFixed(2);
    });
  }

  Future<void> _selectLabourIds(DPRLabourConsumption item) async {
    if (item.skill == null) {
      _showError('Please select skill first');
      return;
    }

    final availableLabours =
    labours.where((l) => l.skill == item.skill).toList();

    final selected = await showDialog<List<int>>(
      context: context,
      builder: (context) => _LabourSelectionDialog(
        labours: availableLabours,
        selectedIds: item.labourIds,
      ),
    );

    if (selected != null) {
      setState(() => item.labourIds = selected);
      print(' Selected labour IDs: $selected');
    }
  }

  void _submitDPR() async {
    if (!_formKey.currentState!.validate()) return;

    if (userId == null) {
      _showError('User not logged in');
      return;
    }

    dprMaterials.removeWhere((m) =>
    m.materialId == null ||
        (double.tryParse(m.quantity) ?? 0) <= 0 ||
        (double.tryParse(m.rate) ?? 0) <= 0 ||
        (double.tryParse(m.amount) ?? 0) <= 0);

    if (dprMaterials.isEmpty) {
      _showError('Please add at least one valid material');
      return;
    }

    for (final m in dprMaterials) {
      if (m.chainageFrom.isEmpty || m.chainageTo.isEmpty) {
        _showError('Please enter material chainage properly');
        return;
      }
    }

    for (final l in dprLabours) {
      final hrs = double.tryParse(l.hours) ?? 0;
      final charges = double.tryParse(l.charges) ?? 0;

      if (l.skill == null) {
        _showError('Please select labour skill');
        return;
      }

      if (hrs <= 0 || charges <= 0) {
        _showError('Labour hours and charges must be greater than 0');
        return;
      }

      if (l.labourIds.isEmpty) {
        _showError('Please select at least one labour');
        return;
      }
    }

    final DateTime safeDate =
    selectedDate != null && selectedDate!.isAfter(DateTime.now())
        ? DateTime.now()
        : selectedDate ?? DateTime.now();

    setState(() => isSubmitting = true);

    try {
      if (selectedFiles.isNotEmpty && uploadedFileIds.isEmpty) {
        await _uploadFiles();
      }

      final dpr = DPRModel(
        date: DateFormat('yyyy-MM-dd').format(safeDate),
        projectId: widget.projectId,
        weatherConditions: _weatherController.text,
        dimension: _dimensionController.text,
        safetyIncidents: _safetyController.text,
        remarks: _remarksController.text,
        submittedBy: userId!,
        materialCost: _getMaterialCost(),
        labourCost: _getLabourCost(),
        machineryCost: _getMachineryCost(),
        totalCost:
        _getMaterialCost() + _getLabourCost() + _getMachineryCost(),
        materials: dprMaterials,
        labourConsumptions: dprLabours,
        machinery: dprMachinery,
        fileIds: uploadedFileIds,
      );

      debugPrint('📤 FINAL DPR PAYLOAD: ${dpr.toJson()}');

      await _dprController.createDPR(dpr);

      if (mounted) {
        _showSuccess('DPR Created Successfully!');
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('Failed to submit DPR');
      debugPrint('❌ DPR ERROR: $e');
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  void _showError(String msg) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg, style: TextStyle(fontSize: 12)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating));

  void _showSuccess(String msg) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg, style: TextStyle(fontSize: 12)),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating));

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Color(0xFFF15716),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Create DPR',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Center(
                    child: Text(
                      'Project #${widget.projectId}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              titlePadding: EdgeInsets.only(left: 16, bottom: 14),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF15716),
                      Color(0xFFFF7A3D),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -40,
                      bottom: -40,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Form Content
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    _buildCard('Basic Information', Icons.info_outline, [
                      _buildDateField(),
                      SizedBox(height: 8),
                      _buildField(_weatherController, 'Weather', Icons.wb_sunny_outlined),
                      SizedBox(height: 8),
                      _buildField(_dimensionController, 'Dimension', Icons.straighten),
                      SizedBox(height: 8),
                      _buildField(_safetyController, 'Safety', Icons.security),
                      SizedBox(height: 8),
                      _buildField(_remarksController, 'Remarks', Icons.note, maxLines: 2),
                    ]),
                    SizedBox(height: 10),
                    _buildCard('Materials', Icons.inventory_2, [
                      ..._buildMaterialForms(),
                      SizedBox(height: 6),
                      _buildAddBtn('Add Material', () {
                        setState(() => dprMaterials.add(DPRMaterial()));
                      }),
                    ]),
                    SizedBox(height: 10),
                    _buildCard('Labour', Icons.groups, [
                      ..._buildLabourForms(),
                      SizedBox(height: 6),
                      _buildAddBtn('Add Labour', () {
                        setState(() => dprLabours.add(DPRLabourConsumption()));
                      }),
                    ]),
                    SizedBox(height: 10),
                    _buildCard('Machinery', Icons.construction, [
                      ..._buildMachineryForms(),
                      SizedBox(height: 6),
                      _buildAddBtn('Add Machinery', () {
                        setState(() => dprMachinery.add(DPRMachinery()));
                      }),
                    ]),
                    SizedBox(height: 10),
                    _buildCard('Attachments', Icons.attach_file, [
                      if (selectedFiles.isNotEmpty) ...[
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: selectedFiles
                              .map((f) => Chip(
                            label: Text(
                              f.name.length > 12
                                  ? '${f.name.substring(0, 12)}...'
                                  : f.name,
                              style: TextStyle(fontSize: 10),
                            ),
                            deleteIconColor: Colors.red,
                            onDeleted: () {
                              setState(() => selectedFiles.remove(f));
                            },
                            padding: EdgeInsets.all(4),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 8),
                      ],
                      OutlinedButton.icon(
                        onPressed: _pickImages,
                        icon: Icon(Icons.photo_library, size: 16),
                        label: Text('Select Images', style: TextStyle(fontSize: 11)),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10),
                    _buildCostSummary(),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : _submitDPR,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isSubmitting
                            ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle,color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text('Submit DPR',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF15716).withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: Color(0xFFF15716)),
                SizedBox(width: 8),
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142))),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10), child: Column(children: children)),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            selectedDate = date;
            _dateController.text = DateFormat('yyyy-MM-dd').format(date);
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 14, color: Color(0xFFF15716)),
            SizedBox(width: 8),
            Text(_dateController.text, style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(fontSize: 11),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 10),
        prefixIcon: Icon(icon, size: 16, color: Color(0xFFF15716)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
    );
  }

  List<Widget> _buildMaterialForms() {
    return List.generate(dprMaterials.length, (i) {
      final item = dprMaterials[i];
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFF15716),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 6),
                Text('Material', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                Spacer(),
                if (dprMaterials.length > 1)
                  InkWell(
                    onTap: () => setState(() => dprMaterials.removeAt(i)),
                    child: Icon(Icons.close, size: 16, color: Colors.red),
                  ),
              ],
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: item.materialId,
              hint: Text('Select', style: TextStyle(fontSize: 10)),
              style: TextStyle(fontSize: 10, color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                filled: true,
                fillColor: Colors.white,
              ),
              isExpanded: true,
              items: materials
                  .map((m) => DropdownMenuItem<int>(
                  value: m.id,
                  child: Text('${m.name} (${m.unit})',
                      style: TextStyle(fontSize: 10))))
                  .toList(),
              onChanged: (v) => setState(() => item.materialId = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                    child: _buildTinyField('Qty', (v) {
                      item.quantity = v;
                      _calculateAmount(item);
                    })),
                SizedBox(width: 6),
                Expanded(
                    child: _buildTinyField('Rate', (v) {
                      item.rate = v;
                      _calculateAmount(item);
                    })),
                SizedBox(width: 6),
                Expanded(
                    child: _buildTinyField('Amount', (v) {},
                        readOnly: true, value: item.amount)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _buildTinyField('From', (v) => item.chainageFrom = v)),
                SizedBox(width: 6),
                Expanded(child: _buildTinyField('To', (v) => item.chainageTo = v)),
              ],
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildLabourForms() {
    final skills = labours.map((l) => l.skill).toSet().toList();

    return List.generate(dprLabours.length, (i) {
      final item = dprLabours[i];
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.green.shade100),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFF15716),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 6),
                Text('Labour', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                Spacer(),
                if (dprLabours.length > 1)
                  InkWell(
                    onTap: () => setState(() => dprLabours.removeAt(i)),
                    child: Icon(Icons.close, size: 16, color: Colors.red),
                  ),
              ],
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: item.skill,
              hint: Text('Select Skill', style: TextStyle(fontSize: 10)),
              style: TextStyle(fontSize: 10, color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                filled: true,
                fillColor: Colors.white,
              ),
              isExpanded: true,
              items: skills
                  .map((s) => DropdownMenuItem<String>(
                  value: s, child: Text(s, style: TextStyle(fontSize: 10))))
                  .toList(),
              onChanged: (v) {
                setState(() {
                  item.skill = v;
                  item.labourIds = [];
                });
              },
              validator: (v) => v == null ? 'Required' : null,
            ),
            SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: () => _selectLabourIds(item),
              icon: Icon(Icons.people, size: 12),
              label: Text('Workers (${item.labourIds.length})',
                  style: TextStyle(fontSize: 10)),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size(0, 28),
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                    child: _buildTinyField('Hours', (v) => item.hours = v, req: true)),
                SizedBox(width: 6),
                Expanded(
                    child: _buildTinyField('Charges', (v) => item.charges = v, req: true)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _buildTinyField('From', (v) => item.chainageFrom = v)),
                SizedBox(width: 6),
                Expanded(child: _buildTinyField('To', (v) => item.chainageTo = v)),
              ],
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildMachineryForms() {
    return List.generate(dprMachinery.length, (i) {
      final item = dprMachinery[i];
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.orange.shade100),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFF15716),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 6),
                Text('Machinery', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                Spacer(),
                if (dprMachinery.length > 1)
                  InkWell(
                    onTap: () => setState(() => dprMachinery.removeAt(i)),
                    child: Icon(Icons.close, size: 16, color: Colors.red),
                  ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                    child: _buildTinyField('Code', (v) => item.machineCode = v,
                        req: true)),
                SizedBox(width: 6),
                Expanded(
                    child: _buildTinyField('Name', (v) => item.machineName = v,
                        req: true)),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _buildTinyField('From', (v) => item.chainageFrom = v)),
                SizedBox(width: 6),
                Expanded(child: _buildTinyField('To', (v) => item.chainageTo = v)),
              ],
            ),
            SizedBox(height: 6),
            _buildTinyField('Hours', (v) => item.workingHours = v),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _buildTinyField('Fuel Type', (v) => item.fuelType = v)),
                SizedBox(width: 6),
                Expanded(
                    child: _buildTinyField('Consumed', (v) => item.fuelConsumed = v)),
              ],
            ),
            SizedBox(height: 6),
            _buildTinyField('Amount (₹)', (v) => item.fuelAmount = v),
          ],
        ),
      );
    });
  }

  Widget _buildTinyField(String label, Function(String) onChanged,
      {bool req = false, bool readOnly = false, String? value}) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      readOnly: readOnly,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 10),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        filled: true,
        fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
      ),
      validator: req ? (v) => v == null || v.isEmpty ? 'Required' : null : null,
    );
  }

  Widget _buildAddBtn(String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(Icons.add, size: 12),
      label: Text(label, style: TextStyle(fontSize: 11)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Color(0xFFF15716),
        side: BorderSide(color: Color(0xFFF15716)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }

  Widget _buildCostSummary() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF15716), Color(0xFFFF7A3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF15716).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text('Cost Summary',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
          SizedBox(height: 8),
          _costRow('Material', _getMaterialCost()),
          _costRow('Labour', _getLabourCost()),
          _costRow('Machinery', _getMachineryCost()),
          Divider(color: Colors.white38, height: 12, thickness: 1),
          _costRow(
              'Total', _getMaterialCost() + _getLabourCost() + _getMachineryCost(),
              bold: true),
        ],
      ),
    );
  }

  Widget _costRow(String label, double amt, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: bold ? 12 : 10,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text('₹${amt.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: bold ? 13 : 11,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _weatherController.dispose();
    _dimensionController.dispose();
    _safetyController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}

// Labour Selection Dialog
class _LabourSelectionDialog extends StatefulWidget {
  final List<LabourItem> labours;
  final List<int> selectedIds;

  const _LabourSelectionDialog({
    required this.labours,
    required this.selectedIds,
  });

  @override
  State<_LabourSelectionDialog> createState() => _LabourSelectionDialogState();
}

class _LabourSelectionDialogState extends State<_LabourSelectionDialog> {
  late List<int> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Workers', style: TextStyle(fontSize: 13)),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.labours.length,
          itemBuilder: (context, i) {
            final labour = widget.labours[i];
            final isSelected = selected.contains(labour.id);
            return CheckboxListTile(
              title: Text(labour.name, style: TextStyle(fontSize: 12)),
              subtitle: Text(labour.phoneNumber, style: TextStyle(fontSize: 10)),
              value: isSelected,
              dense: true,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    selected.add(labour.id);
                  } else {
                    selected.remove(labour.id);
                  }
                });
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(fontSize: 11)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, selected),
          child: Text('Done (${selected.length})', style: TextStyle(fontSize: 11)),
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF15716)),
        ),
      ],
    );
  }
}