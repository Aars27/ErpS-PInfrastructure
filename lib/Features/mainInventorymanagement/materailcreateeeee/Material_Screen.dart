import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'material_controller.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _thresholdCtrl = TextEditingController();

  int categoryId = 1; // temp (dropdown later)
  int unitId = 1;
  String status = 'active';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MaterialController>().fetchMaterials();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialController>(
      builder: (_, c, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Material Management'),
            backgroundColor: const Color(0xFFFF6B35),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// ADD MATERIAL
              _card(
                title: 'Add Material',
                child: Column(
                  children: [
                    TextField(
                      controller: _nameCtrl,
                      decoration:
                      const InputDecoration(labelText: 'Material Name'),
                    ),
                    TextField(
                      controller: _codeCtrl,
                      decoration:
                      const InputDecoration(labelText: 'Material Code'),
                    ),
                    TextField(
                      controller: _thresholdCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Minimum Threshold'),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          c.addMaterial(
                            context,
                            name: _nameCtrl.text.trim(),
                            categoryId: categoryId,
                            unitId: unitId,
                            status: status,
                            minThreshold:
                            int.parse(_thresholdCtrl.text.trim()),
                            materialCode: _codeCtrl.text.trim(),
                          );

                          _nameCtrl.clear();
                          _codeCtrl.clear();
                          _thresholdCtrl.clear();
                        },
                        child: const Text('Save Material'),
                      ),
                    ),
                  ],
                ),
              ),

              /// HISTORY
              _card(
                title: 'Material History',
                child: c.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: c.materials.map((m) {
                    return ListTile(
                      title: Text(
                        m.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${m.categoryName} • ${m.unitName}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(m.materialCode),
                          Text(
                            'Min: ${m.minThreshold}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(),
          child,
        ],
      ),
    );
  }
}
