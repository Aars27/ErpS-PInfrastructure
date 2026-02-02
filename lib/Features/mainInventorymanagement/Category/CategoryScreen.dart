import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Categorycontroller.dart';



class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CategoryController>().fetchCategories();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (_, c, __) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: const Text('Category Management',style: TextStyle(color: Colors.white),),
            backgroundColor: const Color(0xFFFF6B35),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// ADD CATEGORY CARD
              _card(
                title: 'Add Category',
                child: Column(
                  children: [
                    TextField(
                      controller: _nameCtrl,
                      decoration:
                      const InputDecoration(labelText: 'Category Name'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descCtrl,
                      decoration:
                      const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          c.addCategory(
                            context,
                            name: _nameCtrl.text.trim(),
                            description: _descCtrl.text.trim(),
                          );
                          _nameCtrl.clear();
                          _descCtrl.clear();
                        },
                        child: const Text('Save Category'),
                      ),
                    ),
                  ],
                ),
              ),

              /// HISTORY
              /// HISTORY
              _card(
                title: 'Category History',
                child: c.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : c.categories.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No categories found'),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.categories.length,
                  itemBuilder: (_, i) {
                    final cat = c.categories[i];
                    return ListTile(
                      title: Text(
                        cat.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(cat.description),
                      trailing: Text(
                        cat.createdAt
                            .toLocal()
                            .toString()
                            .split(' ')[0],
                        style: const TextStyle(fontSize: 12),
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
