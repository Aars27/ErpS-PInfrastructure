import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/mainInventorymanagement/Unit/unitController.dart';




class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UnitController>().fetchUnits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitController>(
      builder: (_, c, __) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: const Text('Unit Management',style: TextStyle(color: Colors.white),),
            backgroundColor: const Color(0xFFFF6B35),
          ),
          body: Column(
            children: [
              /// ADD UNIT FORM
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameCtrl,
                          decoration:
                          const InputDecoration(labelText: 'Unit Name'),
                        ),
                        TextField(
                          controller: _descCtrl,
                          decoration:
                          const InputDecoration(labelText: 'Description'),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final msg = await c.addUnit(
                                name: _nameCtrl.text,
                                description: _descCtrl.text,
                              );

                              if (msg != null && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(msg)),
                                );
                                _nameCtrl.clear();
                                _descCtrl.clear();
                              }
                            },
                            child: const Text('Add Unit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// HISTORY
              Expanded(
                child: c.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: c.units.length,
                  itemBuilder: (_, i) {
                    final u = c.units[i];
                    return Card(
                      child: ListTile(
                        title: Text(u.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(u.description),
                        trailing: Text(
                          u.createdAt
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
