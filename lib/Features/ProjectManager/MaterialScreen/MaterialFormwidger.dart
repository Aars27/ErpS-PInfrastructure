// Jab user quantity aur rate enter kare, tab amount auto-calculate ho

import 'package:flutter/material.dart';

class MaterialFormWidget extends StatefulWidget {
  @override
  _MaterialFormWidgetState createState() => _MaterialFormWidgetState();
}

class _MaterialFormWidgetState extends State<MaterialFormWidget> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _calculateAmount() {
    final quantity = double.tryParse(quantityController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 0;
    final amount = quantity * rate;

    amountController.text = amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Quantity'),
          onChanged: (_) => _calculateAmount(), // ✅ Auto-calculate
        ),
        TextField(
          controller: rateController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Rate'),
          onChanged: (_) => _calculateAmount(), // ✅ Auto-calculate
        ),
        TextField(
          controller: amountController,
          readOnly: true, // ✅ Read-only (auto-calculated)
          decoration: InputDecoration(labelText: 'Amount'),
        ),
      ],
    );
  }
}