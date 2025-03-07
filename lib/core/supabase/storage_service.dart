import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageService {
  static SupabaseClient supabase = Supabase.instance.client;

  static Future<String> uploadImage(
      Uint8List imageFile) async {
    String path = "_${DateTime.now().millisecondsSinceEpoch}.jpg";
    await supabase.storage.from('fruits_images').uploadBinary(path, imageFile);

    return supabase.storage.from('fruits_images').getPublicUrl(path);
  }
}
