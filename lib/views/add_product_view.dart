import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/supabase/database_services.dart';
import 'package:fruits_hub_dashboard/core/widgets/custom_text_field.dart';
import 'package:fruits_hub_dashboard/core/widgets/space.dart';
import 'package:fruits_hub_dashboard/models/addition_info.dart';
import 'package:fruits_hub_dashboard/models/product.dart';
import 'package:fruits_hub_dashboard/widgets/add_image_widget.dart';
import 'package:fruits_hub_dashboard/widgets/custom_drop_menu.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    calaryController = TextEditingController();
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
          'إضافة منتج جديد',
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 250, 178, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: const Size(500, 40),
                    ),
                    onPressed: () async {
                      if (g.currentState!.validate()) {
                        try {
                          await addProductToDatabase();
                          clearFileds();
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
                      'اضافة المنتج',
                      style: TextStyle(color: Colors.white),
                    ),
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

  Future<void> addProductToDatabase() async {
    Product product = Product(
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
    await DatabaseServices().addProduct(product);
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
