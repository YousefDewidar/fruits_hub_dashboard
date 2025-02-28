import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/widgets/products_grid_view.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Text(
            'قائمة المنتجات',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        ProductsGridView()
      ],
    );
  }
}
