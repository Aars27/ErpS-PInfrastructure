// main.dart
import 'package:flutter/material.dart';



// Models
class MaterialItem {
  String materialId;
  String quantity;
  String requiredDate;
  String? materialName;
  String? materialCode;

  MaterialItem({
    this.materialId = '',
    this.quantity = '',
    this.requiredDate = '',
    this.materialName,
    this.materialCode,
  });
}

class PurchaseRequisition {
  int? id;
  String prCode;
  String prType;
  String urgencyLevel;
  String status;
  String remarks;
  int userId;
  String createdAt;
  int materialItemsCount;
  String totalQuantity;
  List<MaterialItem> materialItems;

  PurchaseRequisition({
    this.id,
    required this.prCode,
    this.prType = 'NONE',
    this.urgencyLevel = 'MEDIUM',
    this.status = 'DRAFT',
    this.remarks = '',
    this.userId = 1,
    required this.createdAt,
    this.materialItemsCount = 0,
    this.totalQuantity = '0',
    this.materialItems = const [],
  });
}

// Form Screen
class PRFormScreen extends StatefulWidget {
  @override
  _PRFormScreenState createState() => _PRFormScreenState();
}

class _PRFormScreenState extends State<PRFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _prCodeController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String _prType = 'NONE';
  String _urgencyLevel = 'MEDIUM';
  String _status = 'DRAFT';

  List<MaterialItem> _materialItems = [MaterialItem()];

  void _addMaterialItem() {
    setState(() {
      _materialItems.add(MaterialItem());
    });
  }

  void _removeMaterialItem(int index) {
    if (_materialItems.length > 1) {
      setState(() {
        _materialItems.removeAt(index);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase Requisition created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2FF),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent,
        ),
        backgroundColor: Color(0xFFF15716),
        title: Text('Create Purchase Requisition',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.history,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PRHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchase Requisition Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // PR Code
                    TextFormField(
                      controller: _prCodeController,
                      decoration: InputDecoration(
                        labelText: 'PR Code',
                        hintText: 'PR-2024-XXX',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter PR Code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // PR Type and Urgency Level
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _prType,
                            decoration: InputDecoration(
                              labelText: 'PR Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: ['NONE', 'REGULAR', 'URGENT']
                                .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _prType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _urgencyLevel,
                            decoration: InputDecoration(
                              labelText: 'Urgency Level',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: ['LOW', 'MEDIUM', 'HIGH']
                                .map((level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _urgencyLevel = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Status
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: ['DRAFT', 'PENDING', 'APPROVED']
                          .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _status = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Remarks
                    TextFormField(
                      controller: _remarksController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        hintText: 'Enter remarks or notes...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Material Items Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Material Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addMaterialItem,
                          icon: Icon(Icons.add),
                          label: Text('Add Item'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Material Items List
                    ..._materialItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      MaterialItem item = entry.value;

                      return Card(
                        color: Colors.grey[50],
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Item ${index + 1}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  if (_materialItems.length > 1)
                                    IconButton(
                                      icon: Icon(Icons.close, color: Colors.red),
                                      onPressed: () => _removeMaterialItem(index),
                                    ),
                                ],
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Material ID',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  item.materialId = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Quantity',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        item.quantity = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Required Date',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: Icon(Icons.calendar_today),
                                      ),
                                      onChanged: (value) {
                                        item.requiredDate = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Submit PR',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// History Screen
class PRHistoryScreen extends StatelessWidget {
  final List<PurchaseRequisition> prHistory = [
    PurchaseRequisition(
      id: 9,
      prCode: 'PR-2024-008',
      urgencyLevel: 'HIGH',
      status: 'DRAFT',
      remarks: 'Urgent materials required for foundation work',
      createdAt: '2026-01-24',
      materialItemsCount: 2,
      totalQuantity: '1500',
      materialItems: [
        MaterialItem(
          materialId: '1',
          materialName: 'Cement',
          materialCode: 'MAT-CEMENT-001',
          quantity: '500',
          requiredDate: '2026-01-28',
        ),
        MaterialItem(
          materialId: '2',
          materialName: 'Steel Rod',
          materialCode: 'MAT-STEEL-002',
          quantity: '1000',
          requiredDate: '2026-01-28',
        ),
      ],
    ),
    PurchaseRequisition(
      id: 8,
      prCode: 'pr-001',
      urgencyLevel: 'MEDIUM',
      status: 'DRAFT',
      remarks: 'asdas',
      createdAt: '2026-01-24',
      materialItemsCount: 1,
      totalQuantity: '100',
      materialItems: [
        MaterialItem(
          materialId: '9',
          materialName: 'Safety Helmet',
          materialCode: 'MAT-HELMET-009',
          quantity: '100',
          requiredDate: '2026-01-27',
        ),
      ],
    ),
    PurchaseRequisition(
      id: 7,
      prCode: 'PROJ-HWY-2024-0078',
      urgencyLevel: 'HIGH',
      status: 'DRAFT',
      remarks: 'hshshjd',
      createdAt: '2026-01-23',
      materialItemsCount: 1,
      totalQuantity: '2',
      materialItems: [
        MaterialItem(
          materialId: '8',
          materialName: 'Water Tap',
          materialCode: 'MAT-TAP-008',
          quantity: '2',
          requiredDate: '2026-01-26',
        ),
      ],
    ),
    PurchaseRequisition(
      id: 2,
      prCode: 'PR-2024-001',
      urgencyLevel: 'HIGH',
      status: 'DRAFT',
      remarks: 'Urgent materials required for foundation work',
      createdAt: '2026-01-23',
      materialItemsCount: 2,
      totalQuantity: '1500',
      materialItems: [
        MaterialItem(
          materialId: '1',
          materialName: 'Cement',
          materialCode: 'MAT-CEMENT-001',
          quantity: '500',
          requiredDate: '2026-01-24',
        ),
        MaterialItem(
          materialId: '2',
          materialName: 'Steel Rod',
          materialCode: 'MAT-STEEL-002',
          quantity: '1000',
          requiredDate: '2026-01-24',
        ),
      ],
    ),
  ];

  Color _getUrgencyColor(String level) {
    switch (level) {
      case 'HIGH':
        return Colors.red[100]!;
      case 'MEDIUM':
        return Colors.yellow[100]!;
      case 'LOW':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getUrgencyTextColor(String level) {
    switch (level) {
      case 'HIGH':
        return Colors.red[900]!;
      case 'MEDIUM':
        return Colors.yellow[900]!;
      case 'LOW':
        return Colors.green[900]!;
      default:
        return Colors.grey[900]!;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DRAFT':
        return Colors.grey[100]!;
      case 'PENDING':
        return Colors.blue[100]!;
      case 'APPROVED':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'DRAFT':
        return Colors.grey[900]!;
      case 'PENDING':
        return Colors.blue[900]!;
      case 'APPROVED':
        return Colors.green[900]!;
      default:
        return Colors.grey[900]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2FF),
      appBar: AppBar(
        title: Text('Purchase Requisition History'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PRFormScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: prHistory.length,
        itemBuilder: (context, index) {
          final pr = prHistory[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PRDetailScreen(pr: pr),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pr.prCode,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getUrgencyColor(pr.urgencyLevel),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            pr.urgencyLevel,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getUrgencyTextColor(pr.urgencyLevel),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(pr.status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            pr.status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getStatusTextColor(pr.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      pr.remarks,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.inventory_2, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${pr.materialItemsCount} items',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          pr.createdAt,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.file_copy, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'Total: ${pr.totalQuantity}',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Detail Screen
class PRDetailScreen extends StatelessWidget {
  final PurchaseRequisition pr;

  PRDetailScreen({required this.pr});

  Color _getUrgencyColor(String level) {
    switch (level) {
      case 'HIGH':
        return Colors.red[100]!;
      case 'MEDIUM':
        return Colors.yellow[100]!;
      case 'LOW':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getUrgencyTextColor(String level) {
    switch (level) {
      case 'HIGH':
        return Colors.red[900]!;
      case 'MEDIUM':
        return Colors.yellow[900]!;
      case 'LOW':
        return Colors.green[900]!;
      default:
        return Colors.grey[900]!;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DRAFT':
        return Colors.grey[100]!;
      case 'PENDING':
        return Colors.blue[100]!;
      case 'APPROVED':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'DRAFT':
        return Colors.grey[900]!;
      case 'PENDING':
        return Colors.blue[900]!;
      case 'APPROVED':
        return Colors.green[900]!;
      default:
        return Colors.grey[900]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2FF),
      appBar: AppBar(
        title: Text('PR Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pr.prCode,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              pr.remarks,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getUrgencyColor(pr.urgencyLevel),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              pr.urgencyLevel,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getUrgencyTextColor(pr.urgencyLevel),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(pr.status),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              pr.status,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getStatusTextColor(pr.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  Divider(),
                  SizedBox(height: 16),

                  // Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 20, color: Colors.grey[600]),
                                SizedBox(height: 8),
                                Text(
                                  'Created Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  pr.createdAt,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Icon(Icons.inventory_2,
                                    size: 20, color: Colors.grey[600]),
                                SizedBox(height: 8),
                                Text(
                                  'Total Items',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${pr.materialItemsCount}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Card(
                          color: Colors.grey[50],
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Icon(Icons.file_copy,
                                    size: 20, color: Colors.grey[600]),
                                SizedBox(height: 8),
                                Text(
                                  'Total Quantity',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  pr.totalQuantity,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Material Items
                  Text(
                    'Material Items',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  ...pr.materialItems.map((item) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.materialName ?? 'Material',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.materialCode ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'Quantity: ',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  item.quantity,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 24),
                                Text(
                                  'Required: ',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  item.requiredDate,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}