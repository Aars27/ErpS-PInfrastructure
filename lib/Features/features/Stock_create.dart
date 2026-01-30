
import 'package:flutter/material.dart';

class StockCreateScreen extends StatefulWidget {
  const StockCreateScreen({super.key});

  @override
  State<StockCreateScreen> createState() => _StockCreateScreenState();
}

class _StockCreateScreenState extends State<StockCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String? status;
  final qtyCtrl = TextEditingController();
  final minCtrl = TextEditingController();
  final specCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Stock')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field('Material (API later)'),
            const SizedBox(height: 12),
            _field('Location (API later)'),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'IN_STOCK', child: Text('In Stock')),
                DropdownMenuItem(value: 'OUT_OF_STOCK', child: Text('Out of Stock')),
                DropdownMenuItem(value: 'RESERVED', child: Text('Reserved')),
                DropdownMenuItem(value: 'DAMAGED', child: Text('Damaged')),
              ],
              onChanged: (v) => setState(() => status = v),
              validator: (v) => v == null ? 'Select status' : null,
            ),

            const SizedBox(height: 12),
            _input(qtyCtrl, 'Quantity'),
            const SizedBox(height: 12),
            _input(minCtrl, 'Minimum Threshold'),
            const SizedBox(height: 12),
            _input(specCtrl, 'Specifications', maxLines: 3),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('API integration pending')),
                  );
                }
              },
              child: const Text('Create Stock'),
            )
          ],
        ),
      ),
    );
  }

  Widget _field(String label) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      validator: (v) => 'Required',
    );
  }

  Widget _input(TextEditingController c, String label, {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
    );
  }
}
