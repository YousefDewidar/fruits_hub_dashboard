import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabase {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllRecords({
    required String tableName,
  }) async {
    return await supabase.from(tableName).select();
  }

  Future<Map<String, dynamic>> getSingleRecord({
    required String tableName,
    required int uId,
  }) async {
    return await supabase.from(tableName).select().eq('uId', uId).single();
  }

  Future<List<Map<String, dynamic>>> getFilterdRecords({
    required String tableName,
    required String columnName,
    required String value,
  }) async {
    return await supabase.from(tableName).select().eq(columnName, value);
  }

  Future<List<Map<String, dynamic>>> search({
    required String tableName,
    required String columnName,
    required String q,
  }) {
    return supabase.from(tableName).select().ilike(columnName, '%$q%');
  }

  Future<void> setRecord(
      {required String tableName, required Map<String, dynamic> data}) async {
    await supabase.from(tableName).insert(data);
  }

  Future<void> updateRecord({
    required String tableName,
    required Map<String, dynamic> data,
    required String uId,
  }) async {
    await supabase.from(tableName).update(data).eq('uId', uId);
  }

  Future<void> deleteRecord(
      {required String tableName, required int uId}) async {
    await supabase.from(tableName).delete().eq('uId', uId);
  }
}
