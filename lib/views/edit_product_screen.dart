import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/views/add_product_view.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل المنتج'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 260.0),
        child: AddProductScreen(),
      ),
    );
  }
}
