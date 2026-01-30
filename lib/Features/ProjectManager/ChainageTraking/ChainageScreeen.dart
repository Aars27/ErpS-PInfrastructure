

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chainageModal.dart';


class ChainageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<ChainageController>().chainages;

    return Scaffold(
      appBar: AppBar(title: Text('Chainage Tracking')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) => ListTile(
          leading: Icon(Icons.location_on),
          title: Text(data[i]),
        ),
      ),
    );
  }
}
