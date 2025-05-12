import 'dart:io';

import 'package:dietify/models/recipe.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/service/file_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sizer/sizer.dart';

class ExportService {
  Future<File> generateRecipePDF(Recipe recipe) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  recipe.title,
                  style: pw.TextStyle(
                    fontSize: 28.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 2.h),
              if (recipe.description != null && recipe.description!.isNotEmpty)
                pw.Text(
                  recipe.description!,
                  style: pw.TextStyle(fontSize: 24.sp),
                ),
              pw.Divider(),
              pw.Text(
                'Ingredientes:',
                style: pw.TextStyle(
                    fontSize: 20.sp, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 2.h),
              ...recipe.ingredients.map(
                (i) => pw.Text(
                  '- $i',
                  style: pw.TextStyle(fontSize: 20.sp),
                ),
              ),
              pw.SizedBox(height: 4.h),
              pw.Text(
                'Pasos:',
                style: pw.TextStyle(
                    fontSize: 20.sp, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 4.h),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: List.generate(recipe.steps.length, (i) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 4),
                    child: pw.Text('${i + 1}. ${recipe.steps[i]}',
                        style: pw.TextStyle(fontSize: 20.sp)),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );

    return FileService.savePDF("${recipe.title}.pdf", pdf);
  }

  Future<File> generateWorkoutPDF(Workout workout) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  workout.name ?? 'Entrenamiento',
                  style: pw.TextStyle(
                    fontSize: 28.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 4.h),
              pw.Text(
                workout.notes!,
                style: pw.TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 4.h),
              pw.Text(
                "Calorías: ${workout.calories ?? '-'}",
                style: pw.TextStyle(fontSize: 18.sp),
              ),
              pw.SizedBox(height: 4.h),
              pw.Text(
                "Duración: ${workout.duration ?? '-'}",
                style: pw.TextStyle(fontSize: 18.sp),
              ),
              pw.SizedBox(height: 4.h),
              pw.Text(
                "Intensidad: ${workout.intensity ?? '-'}",
                style: pw.TextStyle(fontSize: 18.sp),
              ),
              pw.SizedBox(height: 8.h),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 8.h),
              pw.Text(
                'Músculos trabajados:',
                style: pw.TextStyle(
                  fontSize: 20.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 2.h),
              ...?workout.muscles?.split(',').map((muscle) => pw.Bullet(
                  text: muscle.trim(), style: pw.TextStyle(fontSize: 18.sp))),
            ],
          ),
        ),
      ),
    );

    return FileService.savePDF("${workout.name}.pdf", pdf);
  }
}
