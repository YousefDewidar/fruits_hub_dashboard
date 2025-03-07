import 'dart:developer';

import 'package:fruits_hub_dashboard/core/supabase/database.dart';
import 'package:fruits_hub_dashboard/models/product.dart';

class DatabaseServices extends SupabaseDatabase {
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await getAllRecords(tableName: 'products');
      return response.map((item) => Product.fromMap(item)).toList();
    } catch (e) {
      log('error: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await setRecord(tableName: 'products', data: product.toMap());
    } catch (e) {
      log('error is $e');
    }
  }

  Future<void> editProduct(
    Product product,
  ) async {
    try {
      await updateRecord(
        tableName: 'products',
        data: product.toMap(),
        id: product.id.toString(),
      );
    } catch (e) {
      log('error is $e');
    }
  }

  deleteProduct(int id) async {
    try {
      await deleteRecord(
        tableName: 'products',
        id: id.toString(),
      );
    } catch (e) {
      log('error is $e');
    }
  }
}
