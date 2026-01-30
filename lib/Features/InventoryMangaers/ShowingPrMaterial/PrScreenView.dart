import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smp_erp/Features/InventoryMangaers/ShowingPrMaterial/ShowingprController.dart';



class PRListScreen extends StatefulWidget {
  const PRListScreen({super.key});

  @override
  State<PRListScreen> createState() => _PRListScreenState();
}

class _PRListScreenState extends State<PRListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PRshowingController>().fetchPRs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PRshowingController>(
      builder: (_, controller, __) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Purchase Requests'),
            backgroundColor: const Color(0xFFFF6B35),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.prs.length,
            itemBuilder: (_, i) {
              final pr = controller.prs[i];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(
                    pr.prCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Status: ${pr.status} | Urgency: ${pr.urgencyLevel}',
                  ),
                  childrenPadding: const EdgeInsets.all(12),
                  children: [
                    _info('Total Items', pr.itemsCount.toString()),
                    _info('Total Qty', pr.totalQuantity),
                    _info('Remarks', pr.remarks),
                    const Divider(),

                    /// MATERIAL LIST
                    ...pr.items.map(
                          (m) => ListTile(
                        title: Text(m.materialName),
                        subtitle: Text('${m.quantity} ${m.unit}'),
                        trailing: Text(m.materialCode),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (pr.status == 'DRAFT')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              controller.submitPR(pr.id),
                          child: const Text('Submit PR'),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _info(String l, String v) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(child: Text(l)),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
