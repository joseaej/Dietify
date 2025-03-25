import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService extends ChangeNotifier {
  final Supabase _supabase = Supabase.instance;
  Future<String> savePhotoToBucket(String path , File file){
    return _supabase.client.storage.from("url_photos").upload(path, file);
    
  }
}