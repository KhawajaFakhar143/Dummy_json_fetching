import 'package:flutter/material.dart';
import 'screens/product_list/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DummyJSON Product App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductListScreen(),
      );
    
  }
}