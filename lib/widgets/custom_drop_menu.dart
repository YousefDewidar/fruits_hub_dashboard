import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';

class CustomDropMenu extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;
  const CustomDropMenu({
    super.key,
    required this.onChanged,
    required this.hint,
    required this.items,
  });
  final String hint;

  @override
  State<CustomDropMenu> createState() => _CustomDropMenuState();
}

class _CustomDropMenuState extends State<CustomDropMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFA),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffE6E9EA)),
      ),
      child: DropdownButton(
        underline: const SizedBox(),
        value: selectedValue,
        menuWidth: 300,
        isExpanded: true,
        borderRadius: BorderRadius.circular(5),
        hint: Text(widget.hint,
            textAlign: TextAlign.right,
            style: TextStyles.bold13.copyWith(color: AppColors.greyColor)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        items: widget.items,
        onChanged: (val) {
          selectedValue = val;
          widget.onChanged!(selectedValue);
          setState(() {});
        },
      ),
    );
  }
}
