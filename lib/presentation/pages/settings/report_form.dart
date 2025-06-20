import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dietify/presentation/widgets/form_widget.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _supportEmail = 'armandoespi25@gmail.com';

  final inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  );

  Future<void> _sendEmail() async {
    final subject = Uri.encodeComponent(_titleController.text);
    final body = Uri.encodeComponent(_descriptionController.text);

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      query: 'subject=$subject&body=$body',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el correo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportar un problema"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              form(
                _titleController,
                "Asunto",
                const Icon(Icons.subject),
                inputBorder,
                const EdgeInsets.only(bottom: 20),
                isPassword: false,
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Escribe un asunto.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "Descripción del problema",
                  hintText: "Describe brevemente el error o sugerencia...",
                  border: OutlineInputBorder(
                    borderRadius: inputBorder,
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La descripción no puede estar vacía.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendEmail();
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text("Enviar reporte"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
