import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedProcessIAService {
  Future<void> processImage(String route) async {
    final inputImage = InputImage.fromFilePath(route);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String extractedText = recognizedText.text;
    debugPrint(extractedText);
  }
}
