// // ignore_for_file: must_be_immutable

// import 'package:dietify/home.dart';
// import 'package:dietify/services/authservice.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';

// class LoginScreen extends StatelessWidget {
//   String? error = "";
//   LoginScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     const inputBorder = BorderRadius.vertical(
//       bottom: Radius.circular(10.0),
//       top: Radius.circular(20.0),
//     );

//     return Center(
//       child: FlutterLogin(
//         title: 'Dietify',
//         logo: const AssetImage('images/aguacate.png'),
//         onLogin: (loginData) async {
//           error = await AuthService().signInAccount(loginData);
//           return error;
//         },
//         onSignup: (signupData) async {
//           String? error = await AuthService().registerAccount(signupData, context);
//         },
//         onSubmitAnimationCompleted: () {
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => Home(),
//           ));
//         },
//         //messages of login
//         messages: LoginMessages(
//           userHint: 'Usuario',
//           passwordHint: 'Contraseña',
//           confirmPasswordHint: 'Confirmar',
//           loginButton: 'ACCEDER',
//           signupButton: 'REGISTRASE',
//           forgotPasswordButton: '¿Olvidó su contraseña?',
//           recoverPasswordButton: 'AYUDA ME',
//           goBackButton: 'VOLVER',
//           confirmPasswordError: 'Las contraseñas no coinciden',
//           recoverPasswordIntro: "Recupera su contraseña aqui",
//           recoverPasswordDescription:
//               'Ingresa tu usuario y te enviaremos un enlace para restablecer tu contraseña.El correo puede tardar varios minutos',
//           recoverPasswordSuccess: 'Contraseña cambiada con exito',
//         ),
//         onRecoverPassword: (loginData) async {
//           error = await AuthService().resertPassword(loginData as LoginData);
//           return error;
//         },
//         theme: LoginTheme(
//           primaryColor: const Color.fromARGB(255, 97, 173, 137),
//           accentColor: const Color.fromARGB(255, 255, 255, 255),
//           errorColor: const Color.fromARGB(255, 255, 255, 255),
//           switchAuthTextColor: Colors.white,
      
//           titleStyle: const TextStyle(
//             color: Color.fromARGB(255, 255, 255, 255),
//             fontFamily: 'Quicksand',
//             fontWeight: FontWeight.bold,
//             fontSize: 50,
//             letterSpacing: 5,
//           ),
//           bodyStyle: const TextStyle(
//             color: Colors.white,
//             fontStyle: FontStyle.italic,
//           ),
//           buttonStyle: const TextStyle(
//             fontWeight: FontWeight.w800,
//             color: Color.fromARGB(255, 255, 255, 255),
//           ),
      
//           //login theme
//           cardTheme: CardTheme(
//             color: const Color.fromARGB(255, 157, 219, 156),
//             elevation: 5,
//             margin: const EdgeInsets.only(top: 15),
//             shape: ContinuousRectangleBorder(
//                 borderRadius: BorderRadius.circular(100.0)),
//           ),
//           inputTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: const Color.fromARGB(255, 157, 219, 156).withOpacity(.1),
//             contentPadding: EdgeInsets.zero,
//             errorStyle: const TextStyle(
//                 backgroundColor: Color.fromARGB(255, 157, 219, 156),
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontStyle: FontStyle.italic),
//             labelStyle: const TextStyle(fontSize: 12),
//             // borders
//             enabledBorder: const UnderlineInputBorder(
//               borderSide:
//                   BorderSide(color: Color.fromARGB(255, 210, 152, 25), width: 4),
//               borderRadius: inputBorder,
//             ),
//             focusedBorder: const UnderlineInputBorder(
//               borderSide:
//                   BorderSide(color: Color.fromARGB(255, 210, 152, 25), width: 5),
//               borderRadius: inputBorder,
//             ),
//             errorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 7),
//               borderRadius: inputBorder,
//             ),
//             focusedErrorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade400, width: 8),
//               borderRadius: inputBorder,
//             ),
//             disabledBorder: const UnderlineInputBorder(
//               borderSide:
//                   BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 5),
//               borderRadius: inputBorder,
//             ),
//           ),
      
//           buttonTheme: LoginButtonTheme(
//             splashColor: const Color.fromARGB(255, 210, 152, 25),
//             backgroundColor: const Color.fromARGB(255, 210, 152, 25),
//             highlightColor: const Color.fromARGB(255, 168, 86, 32),
//             elevation: 9.0,
//             highlightElevation: 6.0,
//             shape: BeveledRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? error;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color.fromRGBO(226, 219, 122, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Dietify',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(226, 219, 122, 1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      border: UnderlineInputBorder(
                        borderRadius: inputBorder,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: UnderlineInputBorder(
                        borderRadius: inputBorder,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(226, 219, 122, 1),
                    ),
                    child: const Text('ACCEDER'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}