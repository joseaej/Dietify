import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''
TÉRMINOS Y CONDICIONES DE USO DE DIETIFY

Última actualización: 07/05/2025

Bienvenido/a a Dietify, una aplicación diseñada para ayudarte a mejorar tu bienestar a través de dietas, recetas saludables y una comunidad activa. Al utilizar esta aplicación, aceptas los siguientes Términos y Condiciones. Si no estás de acuerdo con alguno de ellos, por favor no utilices la aplicación.

1. ACEPTACIÓN DE LOS TÉRMINOS  
Al registrarte o usar Dietify, reconoces haber leído, entendido y aceptado estos Términos y Condiciones.

2. DESCRIPCIÓN DEL SERVICIO  
Dietify es una plataforma que permite:
- Explorar y compartir recetas saludables.
- Conectar con otros usuarios.
- Crear dietas personalizadas y registrar entrenamientos.
- Guardar y enviar recetas a contactos.

3. USO ADECUADO  
Te comprometes a no:
- Publicar contenido ofensivo, ilegal o engañoso.
- Usar Dietify con fines comerciales sin autorización.
- Usar bots, scrapers u otros métodos automatizados para recopilar datos.
- Suplantar la identidad de otros usuarios o difundir información falsa.

4. CUENTA DE USUARIO  
- Debes proporcionar información veraz al registrarte.
- Eres responsable de mantener la confidencialidad de tu cuenta.
- Dietify puede suspender o eliminar tu cuenta si incumples estos términos.

5. PROPIEDAD INTELECTUAL  
Todos los elementos de Dietify (marca, logo, diseño, funcionalidades, etc.) son propiedad de sus desarrolladores o están licenciados para su uso. No puedes copiarlos, modificarlos ni distribuirlos sin permiso.

6. CONTENIDO GENERADO POR USUARIOS  
Eres el único responsable del contenido que compartas (recetas, comentarios, imágenes, etc.). Dietify se reserva el derecho de eliminar contenido que infrinja estos términos o que considere inapropiado.

7. LIMITACIÓN DE RESPONSABILIDAD  
Dietify no garantiza que la información proporcionada sea 100% precisa o adecuada a todos los usuarios. Antes de realizar cambios importantes en tu dieta o entrenamiento, consulta con un profesional de la salud.

8. CAMBIOS EN LOS TÉRMINOS  
Podemos actualizar estos Términos y Condiciones en cualquier momento. Te notificaremos los cambios importantes. El uso continuado de la app implica tu aceptación de los nuevos términos.

9. CONTACTO  
Si tienes dudas o comentarios sobre estos términos, puedes contactarnos en: armandoespi25@gmail.com
          ''',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
