import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class IAService {
  Future<String> processImage(String route) async {
    final inputImage = InputImage.fromFilePath(route);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String extractedText = recognizedText.text;
    return extractedText;
  }

  void generatePrompt(BuildContext context, String prompt) async {
    try {
      final openAI = OpenAI.instance.build(
        token: dotenv.env["OPEN_AI_KEY"],
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
        enableLog: true,
      );

      final request = CompleteText(
        prompt: prompt,
        model: ModelFromValue(model: "davinci-002"),
        maxTokens: 150,
        temperature: 0.2,
      );

      final response = await openAI.onCompletion(request: request);

      if (response != null && response.choices.isNotEmpty) {
        final jsonText = response.choices.first.text.trim();
        debugPrint("🔍 Respuesta de OpenAI:\n$jsonText");
      } else {
        debugPrint("⚠️ No se obtuvo respuesta de OpenAI");
      }
    } catch (e) {
      debugPrint("❌ ERROR: $e");
    }
  }
}
