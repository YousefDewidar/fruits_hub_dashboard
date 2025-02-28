import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/space.dart';
import 'package:fruits_hub_dashboard/models/product.dart';
import 'package:fruits_hub_dashboard/views/edit_product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditProductScreen()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xffF3F5F7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceV(16),
            Center(
              child: CachedNetworkImage(
                imageUrl: product.img,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  product.title,
                  style: TextStyles.bold23,
                ),
                const Spacer(),
                Text(
                  "${product.price} جنيه / ",
                  textDirection: TextDirection.rtl,
                  style: TextStyles.bold19.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  'كيلو',
                  style: TextStyles.semiBold16.copyWith(
                    color: AppColors.lightSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
