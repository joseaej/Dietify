import 'package:Dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

enum Difficulty { Alta, Media, Baja }

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController musclesController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  Difficulty? selectedDifficulty = Difficulty.Alta;

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: font),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Añadir Entrenamiento", style: TextStyle(color: font)),
          backgroundColor: orange,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.check, color: font),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await Supabase.instance.client.from('workout').insert({
                      'name': nameController.text,
                      'duration': int.tryParse(durationController.text) ?? 0,
                      'type': typeController.text,
                      'intensity': selectedDifficulty.toString().split('.').last,
                      'notes': notesController.text,
                      'muscles': musclesController.text,
                      'calories': int.tryParse(caloriesController.text) ?? 0,
                    });

                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, "/home");
                  } catch (e) {
                    print('Error al guardar: ${e.toString()}');
                    if (!mounted) return;
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        
                          content: Text('Error al guardar: ${e.toString()}')),
                    );
                  }
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Nombre del Entrenamiento",
                    labelText: 'Nombre del Entrenamiento',
                    labelStyle: TextStyle(color: background),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del entrenamiento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: durationController,
                  decoration: InputDecoration(
                    hintText: "Duración (minutos)",
                    labelText: 'Duración',
                    labelStyle: TextStyle(color: background),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la duración del entrenamiento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(
                    labelText: 'Tipo',
                    hintText: 'Tipo',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un tipo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: 'Notas',
                    hintText: 'Notas',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: musclesController,
                  decoration: InputDecoration(
                    labelText: 'Musculos',
                    hintText: 'Musculos',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: caloriesController,
                  decoration: InputDecoration(
                    labelText: 'Calorias',
                    hintText: 'Calorias (Kcal)',
                    labelStyle:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: DropdownMenu<Difficulty>(
                    initialSelection: Difficulty.Alta,
                    requestFocusOnTap: true,
                    label: const Text('Dificultad'),
                    onSelected: (Difficulty? difficulty) {
                      setState(() {
                        selectedDifficulty = difficulty;
                      });
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry<Difficulty>(
                        value: Difficulty.Baja,
                        label: 'Fácil',
                      ),
                      DropdownMenuEntry<Difficulty>(
                        value: Difficulty.Media,
                        label: 'Medio',
                      ),
                      DropdownMenuEntry<Difficulty>(
                        value: Difficulty.Alta,
                        label: 'Difícil',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
