import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({
    super.key,
    required this.onPathChanged,
  });
  final ValueChanged<Uint8List?> onPathChanged;
  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  bool isSelected = false;
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        InkWell(
          onTap: () async {
            imageBytes = await ImagePickerWeb.getImageAsBytes();
            if (imageBytes != null) {
              setState(() {
                isSelected = true;
                widget.onPathChanged(imageBytes);
              });
            }
          },
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xffF3F5F7),
            ),
            child: isSelected
                ? Image.memory(imageBytes!)
                : const Center(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: AppColors.secondaryColor,
                      size: 50,
                    ),
                  ),
          ),
        ),
        isSelected
            ? Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: IconButton.filled(
                    onPressed: () {
                      isSelected = false;
                      imageBytes = null;
                      widget.onPathChanged(imageBytes);
                      setState(() {});
                    },
                    icon: const Icon(Icons.close)),
              )
            : const SizedBox(),
      ],
    );
  }
}
