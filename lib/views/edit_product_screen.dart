// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/supabase/database_services.dart';
import 'package:fruits_hub_dashboard/core/widgets/custom_text_field.dart';
import 'package:fruits_hub_dashboard/core/widgets/space.dart';
import 'package:fruits_hub_dashboard/models/addition_info.dart';
import 'package:fruits_hub_dashboard/models/product.dart';
import 'package:fruits_hub_dashboard/widgets/add_image_widget.dart';
import 'package:fruits_hub_dashboard/widgets/custom_drop_menu.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> g = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController calaryController;
  String? expiredDateValue;
  bool isFeatured = false;
  File? imgFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.title);
    descriptionController = TextEditingController(text: widget.product.desc);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    discountController =
        TextEditingController(text: widget.product.discount.toString());
    calaryController =
        TextEditingController(text: widget.product.additionInfo.calary);
    expiredDateValue = widget.product.additionInfo.dateExpired;
    isFeatured = widget.product.isFeatured;
    // imgFile =widget.product.img;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    calaryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعديل المنتج',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: autovalidateMode,
            key: g,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AddImageWidget(),
                  const SpaceV(16),
                  CustomTextField(
                    controller: nameController,
                    hint: 'اسم المنتج',
                  ),
                  const SpaceV(12),
                  CustomTextField(
                    controller: descriptionController,
                    hint: 'وصف المنتج',
                  ),
                  const SpaceV(12),
                  CustomTextField(
                    controller: priceController,
                    hint: 'سعر المنتج',
                  ),
                  const SpaceV(12),
                  CustomTextField(
                    controller: discountController,
                    hint: 'نسبة الخصم',
                    reqired: false,
                  ),
                  const SpaceV(12),
                  CustomTextField(
                    controller: calaryController,
                    hint: 'السعرات',
                    reqired: false,
                  ),
                  const SpaceV(12),
                  CustomDropMenu(
                    hint: 'الصلاحية',
                    items: dateExpiredList,
                    onChanged: (val) {
                      expiredDateValue = val;
                      setState(() {});
                    },
                  ),
                  const SpaceV(12),
                  CustomDropMenu(
                    hint: 'منتج مميز',
                    items: isFeaturedList,
                    onChanged: (val) {
                      isFeatured = val == 'true';
                      setState(() {});
                    },
                  ),
                  const SpaceV(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 250, 178, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fixedSize: const Size(500, 40),
                        ),
                        onPressed: () async {
                          if (g.currentState!.validate()) {
                            try {
                              await editProductInDatabase();
                              clearFileds();
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                        child: const Text(
                          'تعديل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SpaceH(15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(221, 244, 67, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fixedSize: const Size(500, 40),
                        ),
                        onPressed: () async {
                          try {
                            await deleteProductFromDatabase();
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'حذف المنتج',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearFileds() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    discountController.clear();
    calaryController.clear();
    expiredDateValue = null;
    isFeatured = false;
  }

  Future<void> editProductInDatabase() async {
    Product product = Product(
      id: widget.product.id,
      title: nameController.text,
      desc: descriptionController.text,
      price: int.parse(priceController.text),
      discount: int.parse(discountController.text),
      img: '',
      additionInfo: AdditionInfo(
        calary: calaryController.text,
        dateExpired: expiredDateValue,
      ),
      isFeatured: isFeatured,
    );
    await DatabaseServices().editProduct(product);
  }

  Future<void> deleteProductFromDatabase() async {
    await DatabaseServices().deleteProduct(widget.product.id);
  }

  List<DropdownMenuItem<String>> get dateExpiredList {
    return const [
      DropdownMenuItem(
        value: 'اسبوع',
        child: Text('اسبوع'),
      ),
      DropdownMenuItem(
        value: 'شهر',
        child: Text('شهر'),
      ),
      DropdownMenuItem(
        value: 'ثلاثة شهور',
        child: Text('ثلاثة شهور'),
      ),
      DropdownMenuItem(
        value: 'عام',
        child: Text('عام'),
      ),
      DropdownMenuItem(
        value: 'ثلاثة أعوام',
        child: Text('ثلاثة أعوام'),
      ),
    ];
  }

  List<DropdownMenuItem<String>> get isFeaturedList {
    return const [
      DropdownMenuItem(
        value: 'true',
        child: Text('مميز'),
      ),
      DropdownMenuItem(
        value: 'false',
        child: Text('غير مميز'),
      ),
    ];
  }
}
