import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffF3F5F7),
        ),
        child: const Center(
          child: Icon(
            Icons.add_a_photo_outlined,
            color: AppColors.secondaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
