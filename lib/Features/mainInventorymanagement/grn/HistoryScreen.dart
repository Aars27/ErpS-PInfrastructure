import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grn_controller.dart';



class GRNHistoryScreen extends StatefulWidget {
  const GRNHistoryScreen({super.key});

  @override
  State<GRNHistoryScreen> createState() => _GRNHistoryScreenState();
}

class _GRNHistoryScreenState extends State<GRNHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<GRNController>().fetchGRNHistory(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<GRNController>();

    if (c.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('GRN History')),
      body: ListView.builder(
        itemCount: c.grns.length,
        itemBuilder: (_, i) {
          final g = c.grns[i];
          return ListTile(
            title: Text(g.gateEntry),
            subtitle: Text('Vehicle: ${g.vehicleNumber}'),
            trailing: Text(g.status),
          );
        },
      ),
    );
  }
}
