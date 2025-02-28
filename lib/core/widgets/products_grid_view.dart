import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/supabase/database_services.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/constant.dart';
import 'package:fruits_hub_dashboard/core/widgets/product_card.dart';
import 'package:fruits_hub_dashboard/models/product.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({
    super.key,
  });

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  List<Product> productsList = [];
  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  void loadProducts() async {
    await DatabaseServices().getAllProducts()
        .then((value) => productsList = value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: kHoripadding),
      sliver: productsList.isEmpty
          ? const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              ),
            )
          : SliverGrid.builder(
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 163 / 166,
              ),
              itemBuilder: (context, index) => ProductCard(
                product: productsList[index],
              ),
            ),
    );
  }
}
