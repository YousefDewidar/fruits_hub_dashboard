import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/core/utils/app_images.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';
import 'package:fruits_hub_dashboard/core/widgets/space.dart';
import 'package:fruits_hub_dashboard/views/add_product_view.dart';
import 'package:fruits_hub_dashboard/views/all_products_view.dart';
import 'package:svg_flutter/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // const AllProductsScreen(),
    const AddProductScreen(),
    const Placeholder()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        textDirection: TextDirection.ltr,
        children: [
          NavigationRail(
            minWidth: 250,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => _selectedIndex = index),
            indicatorColor: AppColors.secondaryColor,
            backgroundColor: AppColors.primaryColor,
            labelType: NavigationRailLabelType.all,
            leading: Row(
              children: [
                Text(
                  'Dashboard',
                  style: TextStyles.bold23.copyWith(color: Colors.white),
                ),
                const SpaceH(13),
                SvgPicture.asset(Assets.imagesLogo, width: 60),
              ],
            ),
            destinations: [
              NavigationRailDestination(
                padding: const EdgeInsets.only(bottom: 15),
                icon: const Icon(
                  Icons.list_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'عرض المنتجات',
                  style: TextStyles.semiBold16.copyWith(color: Colors.white),
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  color: Colors.white,
                  Icons.add_circle,
                ),
                label: Text(
                  'إضافة منتج',
                  style: TextStyles.semiBold16.copyWith(color: Colors.white),
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  color: Colors.white,
                  Icons.shopping_cart,
                ),
                label: Text(
                  'الطلبات',
                  style: TextStyles.semiBold16.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
