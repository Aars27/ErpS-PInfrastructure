import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/StockModal.dart' show StockModel;
import 'package:smp_erp/Features/mainInventorymanagement/StockCreate/stock_controller.dart';



class StockCreateScreen extends StatefulWidget {
  const StockCreateScreen({super.key});
  @override
  State<StockCreateScreen> createState() => _StockCreateScreenState();
}
class _StockCreateScreenState extends State<StockCreateScreen> {

  final _formKey = GlobalKey<FormState>();

  final materialIdCtrl = TextEditingController(text: '1');
  final locationIdCtrl = TextEditingController(text: '1');
  final minCtrl = TextEditingController(text: '100');
  final currentCtrl = TextEditingController(text: '500');
  final qtyCtrl = TextEditingController(text: '500');
  final specCtrl = TextEditingController(text: 'OPC 53 Grade, 50kg bags');


  @override
  Widget build(BuildContext context) {
    return Consumer<StockController>(
      builder: (context, c, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Create Stock')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _field(materialIdCtrl, 'Material ID'),
                  _field(locationIdCtrl, 'Location ID'),
                  _field(minCtrl, 'Min Threshold'),
                  _field(currentCtrl, 'Current Stock'),
                  _field(qtyCtrl, 'Quantity'),
                  _field(specCtrl, 'Specifications'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: c.isLoading
                        ? null
                        : () async {
                      if (!_formKey.currentState!.validate()) return;

                      final stock = StockModel(
                        materialId: int.parse(materialIdCtrl.text),
                        locationId: int.parse(locationIdCtrl.text),
                        status: 'IN_STOCK',
                        minimumThresholdQuantity:
                        int.parse(minCtrl.text),
                        currentStock:
                        int.parse(currentCtrl.text),
                        quantity: int.parse(qtyCtrl.text),
                        specifications: specCtrl.text,
                      );

                      try {
                        await c.createStock(stock);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                Text('Stock created successfully')),
                          );
                          Navigator.pop(context);
                        }
                      } catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to create stock')),
                        );
                      }
                    },
                    child: c.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Create Stock'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(labelText: label),
        validator: (v) =>
        v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }
}
