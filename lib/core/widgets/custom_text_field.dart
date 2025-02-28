import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? suffIcon;
  final bool reqired;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.suffIcon,
    required this.controller,
    this.reqired = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if ((value == null || value.isEmpty) && reqired) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      style: TextStyles.semiBold16,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyles.bold13.copyWith(color: AppColors.greyColor),
        suffixIcon: suffIcon,
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        border: customBorder(),
        enabledBorder: customBorder(),
        focusedBorder: customBorder(),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          width: 1.3,
          color: Color(0xffE6E9EA),
        ));
  }
}
