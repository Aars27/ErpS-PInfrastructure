import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Core/Provider/AllProviders.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MainProviders()
  );

}
