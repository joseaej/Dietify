import 'dart:io';

import 'package:dietify/models/recipe.dart';
import 'package:dietify/service/file_service.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportService {
  Future<File> generateRecipePDF(Recipe recipe) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Padding(
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            children: [
              pw.Text('Receta: ${recipe.title}'),
            ],
          ),
        ),
      ),
    );

    return FileService.savePDF("${recipe.title}.pdf", pdf);
  }
}
