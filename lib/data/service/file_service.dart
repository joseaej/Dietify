import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class FileService {
  static Future<File> savePDF(String name, Document document) async {
    final route = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File('${route!.path}/$name');
    await file.writeAsBytes(await document.save());
    debugPrint(file.path);
    return file;
  }
  static Future<void> openPDF(File file) async{
    final path = file.path;
    await OpenFile.open(path);
  }
}
