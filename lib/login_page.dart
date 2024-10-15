import 'package:dietify/home.dart';
import 'package:dietify/utils/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'Dietify',
      logo: const AssetImage('images/aguacate.png'),
      onLogin: (loginData) async {
        return AuthService().signInAccount(loginData);
      },
      onSignup: (signupData) async {
        return AuthService().registerAccount(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      //messages of login
      messages: LoginMessages(
        userHint: 'Usuario',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'ACCEDER',
        signupButton: 'REGISTRASE',
        forgotPasswordButton: '¿Olvidó su contraseña?',
        recoverPasswordButton: 'AYUDA ME',
        goBackButton: 'VOLVER',
        confirmPasswordError: 'Las contraseñas no coinciden',
        recoverPasswordIntro: "Recupera su contraseña aqui",
        recoverPasswordDescription:
            'Ingresa tu usuario y te enviaremos un enlace para restablecer tu contraseña.El correo puede tardar varios minutos',
        recoverPasswordSuccess: 'Contraseña cambiada con exito',

      ),
      onRecoverPassword: (_) => Future(() => null),
      theme: LoginTheme(
        primaryColor: const Color.fromARGB(255, 97, 173, 137),
        accentColor: const Color.fromARGB(255, 255, 255, 255),
        errorColor: const Color.fromARGB(255, 255, 255, 255),
        switchAuthTextColor: Colors.white,
        
        titleStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          fontSize: 50,
          letterSpacing: 5,
        ),
        bodyStyle: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
        textFieldStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          shadows: [Shadow(color: Color.fromARGB(255, 255, 0, 0), blurRadius: 2)],
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 255, 255, 255),
        ),

        //login theme
        cardTheme: CardTheme(
          color: const Color.fromARGB(255, 157, 219, 156),
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 187, 116, 9).withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(fontSize: 12),
          // borders
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 210, 152, 25), width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 210, 152, 25), width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 5),
            borderRadius: inputBorder,
          ),
        ),
        
        buttonTheme: LoginButtonTheme(
          splashColor: const Color.fromARGB(255, 210, 152, 25),
          backgroundColor: const Color.fromARGB(255, 210, 152, 25),
          highlightColor: const Color.fromARGB(255, 168, 86, 32),
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}