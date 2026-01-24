import 'package:flutter/material.dart';
import 'package:smp_erp/MaterialModel.dart';
import 'package:smp_erp/ProjectResponse.dart';
import 'package:intl/intl.dart';

import '../Core/Constants/ApiConstants.dart';
import '../Core/Constants/ApiService.dart';
import 'InventoryScreen.dart';

class CreatePurchaseRequisitionScreen extends StatefulWidget {
  const CreatePurchaseRequisitionScreen({super.key});

  @override
  State<CreatePurchaseRequisitionScreen> createState() =>
      _CreatePurchaseRequisitionScreenState();
}

class _CreatePurchaseRequisitionScreenState
    extends State<CreatePurchaseRequisitionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _prCodeController = TextEditingController();
  final _remarksController = TextEditingController();

  int? _selectedProjectId;
  String? _selectedProjectCode;
  String? _selectedUrgencyLevel;

  // Urgency Level Options
  final List<String> _urgencyLevels = ['Low', 'Medium', 'High', 'Critical'];

  List<MaterialItem> _materialItems = [MaterialItem()];
  List<MaterialModel> _materials = [];
  List<ProjectModel> _projects = [];
  bool _isLoadingMaterials = false;
  bool _isLoadingProjects = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fetchMaterials();
    _fetchProjects();
  }

  @override
  void dispose() {
    _prCodeController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _fetchProjects() async {
    setState(() {
      _isLoadingProjects = true;
    });

    try {
      final response = await ApiService.get(ApiConstants.projects, requiresAuth: true);
      final projectResponse = ProjectResponse.fromJson(response);
      setState(() {
        _projects = projectResponse.projects;
        _isLoadingProjects = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingProjects = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load projects: $e')),
        );
      }
    }
  }

  Future<void> _fetchMaterials() async {
    setState(() {
      _isLoadingMaterials = true;
    });

    try {
      final response = await ApiService.get(ApiConstants.material, requiresAuth: true);
      final materialResponse = MaterialResponse.fromJson(response);
      setState(() {
        _materials = materialResponse.materials;
        _isLoadingMaterials = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMaterials = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load materials: $e')),
        );
      }
    }
  }

  void _addItem() {
    setState(() {
      _materialItems.add(MaterialItem());
    });
  }

  void _removeItem(int index) {
    setState(() {
      if (_materialItems.length > 1) {
        _materialItems.removeAt(index);
      }
    });
  }



  Future<void> _savePurchaseRequisition() async {
    // ... validation code stays the same ...

    try {
      // Prepare material items array
      final materialItems = _materialItems.map((item) {
        return {
          'material_id': item.materialId,
          'quantity': item.quantity,
          'required_date': '2026-01-26T00:00:00.000Z',
        };
      }).toList();

      // Prepare the complete request body
      final requestBody = {
        'project_id': _selectedProjectId,
        'pr_code': _prCodeController.text.isNotEmpty
            ? _prCodeController.text
            : _selectedProjectCode ?? 'PR-${DateTime.now().year}-001',
        'pr_type': 'INVENTORY', // CHANGED: Was 'Inventory', now 'INVENTORY'
        'urgency_level': _selectedUrgencyLevel?.toUpperCase() ?? 'MEDIUM',
        'status': 'DRAFT',
        'remarks': _remarksController.text.isNotEmpty
            ? _remarksController.text
            : 'Purchase requisition',
        'user_id': 1, // You should get this from your auth/user session
        'approved_by': null,
        'send_to': null,
        'material_items': materialItems,
      };

      print('Sending PR Data: $requestBody');

      // Make single API call with complete PR data
      await ApiService.postMaterial(
        ApiConstants.pr,
        requestBody,
        requiresAuth: true,
      );

      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchase Requisition created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to inventory screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Inventoryscreen()),
        );
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save PR: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Inventoryscreen()),
            );
          },
        ),
        title: const Text(
          'Create Purchase Requisition',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fill the details below to create PR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // PR Details Section
                    const Text(
                      'PR Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Field
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Project',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF475569),
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<int>(
                                value: _selectedProjectId,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  hintText: _isLoadingProjects
                                      ? 'Loading...'
                                      : 'Select Project',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF8FAFC),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                items: _projects.map((project) {
                                  return DropdownMenuItem<int>(
                                    value: project.id,
                                    child: Text(
                                      project.projectName,
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: _isLoadingProjects ? null : (value) {
                                  setState(() {
                                    _selectedProjectId = value;
                                    final selectedProject = _projects.firstWhere(
                                          (p) => p.id == value,
                                    );
                                    _selectedProjectCode = selectedProject.projectCode;
                                    _prCodeController.text = selectedProject.projectCode;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // PR Code Field
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'PR Code',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF475569),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _prCodeController,

                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF1F5F9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Urgency Level Field
                    const Text(
                      'Urgency Level',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedUrgencyLevel,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: 'Select Urgency Level',
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: _urgencyLevels.map((level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getUrgencyColor(level),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                level,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUrgencyLevel = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Remarks/Justification Field
                    const Text(
                      'Remarks / Justification',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _remarksController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter reason for this Submit',
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Material Items Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Material Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFFFF6B35),
                            size: 18,
                          ),
                          label: const Text(
                            'Add Item',
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Material Items List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _materialItems.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        return _buildMaterialItem(index);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isSaving ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: Color(0xFFE2E8F0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),

                    ),

                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : () {
                        if (_formKey.currentState!.validate()) {
                          _savePurchaseRequisition();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Save PR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getUrgencyColor(String level) {
    switch (level) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.yellow;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildMaterialItem(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item #${index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (_materialItems.length > 1)
                IconButton(
                  onPressed: () => _removeItem(index),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Material Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Material Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _materialItems[index].materialId,
                isExpanded: true,
                decoration: InputDecoration(
                  hintText: _isLoadingMaterials
                      ? 'Loading...'
                      : 'Select Material',
                  hintStyle: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: _materials.map((material) {
                  return DropdownMenuItem<int>(
                    value: material.id,
                    child: Text(
                      material.name,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: _isLoadingMaterials ? null : (value) {
                  setState(() {
                    _materialItems[index].materialId = value;
                    final selectedMaterial = _materials.firstWhere(
                          (m) => m.id == value,
                    );
                    _materialItems[index].materialName = selectedMaterial.name;
                    _materialItems[index].materialCode = selectedMaterial.materialCode;
                    _materialItems[index].unit = selectedMaterial.unit?.name;
                    _materialItems[index].categoryId = selectedMaterial.categoryId;
                    _materialItems[index].unitId = selectedMaterial.unitId;
                    _materialItems[index].status = selectedMaterial.status;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Material Code
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Material Code',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _materialItems[index].materialCode ?? '',
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Quantity
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _materialItems[index].quantity = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Unit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Unit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _materialItems[index].unit ?? '',
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Required Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Required Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _materialItems[index].requiredDate != null
                            ? DateFormat('dd/MM/yyyy').format(_materialItems[index].requiredDate!)
                            : '',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF94A3B8),
                          size: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            _materialItems[index].requiredDate = date;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MaterialItem {
  int? materialId;
  String? materialCode;
  String? materialName;
  String? quantity;
  String? unit;
  DateTime? requiredDate;
  int? categoryId;
  int? unitId;
  String? status;

  MaterialItem({
    this.materialId,
    this.materialCode,
    this.materialName,
    this.quantity,
    this.unit,
    this.requiredDate,
    this.categoryId,
    this.unitId,
    this.status,
  });
}





