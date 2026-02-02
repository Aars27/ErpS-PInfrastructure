import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/ProjectManager/PrGenrate/screenview.dart';
import 'Inventory_controller.dart';
import 'ShowingPrMaterial/PrScreenView.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<InventoryController>().fetchInventory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryController>(
      builder: (_, c, __) {
        if (c.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (c.user == null) {
          return const Scaffold(
            body: Center(child: Text('No inventory data')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Inventory'),
            backgroundColor: const Color(0xFFFF6B35),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _card('Inventory Manager', [
                _info('Name', c.user!.name),
                _info('Email', c.user!.email),
                _info('Mobile', c.user!.mobile),
              ]),

              _card('Location', [
                _info('Village', c.location!.village),
                _info('District', c.location!.district),
                _info('State', c.location!.state),
                _info('Country', c.location!.country),
                _info('Pincode', c.location!.pincode),
              ]),


              const SizedBox(height: 20),

              /// INVENTORY MANAGER ACTIONS
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('PR List'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PRListScreen()));
                },
              ),


            ],
          ),
        );
      },
    );
  }

  Widget _stockTile(stock) {
    final bool low = stock.currentStock < stock.minimumThreshold;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: low ? Colors.red : Colors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stock.materialName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(stock.materialCode),
          _info('Category', stock.category),
          _info('Unit', stock.unit),
          _info('Stock', stock.currentStock.toString()),
        ],
      ),
    );
  }

  Widget _card(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(),
        ...children,
      ]),
    );
  }

  Widget _info(String l, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Expanded(child: Text(l)),
        Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    ),
  );
}
