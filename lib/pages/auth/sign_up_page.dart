// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/service/auth_service.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';
import '../../models/profile.dart';
import '../../widgets/form_widget.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

  final _formKey = GlobalKey<FormState>();

  bool seePassword = true;
  late AuthService service;
  @override
  Widget build(BuildContext context) {
    service = Provider.of<AuthService>(context);
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Crea tu cuenta",
                  style: TextStyle(
                      color: blue, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                form(
                  _emailController,
                  "Email",
                  Icon(
                    Icons.email,
                    color: blue,
                  ),
                  inputBorder,
                  EdgeInsets.fromLTRB(30, 10, 30, 0),
                  isPassword: false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Debes ingresar un email";
                    } else if (!_emailRegex.hasMatch(value)) {
                      return "Email incorrecto";
                    }
                    return null;
                  },
                ),
                form(
                  _username,
                  "Usuario",
                  Icon(
                    Icons.person,
                    color: blue,
                  ),
                  inputBorder,
                  EdgeInsets.fromLTRB(30, 10, 30, 0),
                  isPassword: false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Debes ingresar un usuario valido";
                    } else if (value.length < 4) {
                      return "El nombre de usuario debe mas de 4 caracteres";
                    }
                    return null;
                  },
                ),
                PasswordField(
                  controller: _passwordController,
                  texto: "Contraseña",
                  icono: Icon(
                    Icons.lock_outline_rounded,
                    color: blue,
                  ),
                  borde: inputBorder,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Debes ingresar una contraseña";
                    }
                    if (value.length < 6) {
                      return "Debe contener al menos 6 caracteres";
                    }
                    if (!_passwordRegex.hasMatch(value)) {
                      return 'Incluir una letra y un número';
                    }

                    return null;
                  },
                ),
                PasswordField(
                  controller: _confirmpassController,
                  texto: "Confirmar Contraseña",
                  icono: Icon(
                    Icons.lock_outline_rounded,
                    color: blue,
                  ),
                  borde: inputBorder,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Debes ingresar una contraseña";
                    }
                    if (value != _passwordController.text) {
                      return "Las contraseñas deben coincidir";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: _buttonSignUp(context),
                ),
                _rowlinea,
                _rowiconlogin,
                _createaccount,
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton _buttonSignUp(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(blue),
        minimumSize: WidgetStateProperty.all(Size(300, 50)),
      ),
      onPressed: () async {
        try {
          if (_formKey.currentState!.validate() &&
              _passwordController.text == _confirmpassController.text) {
            Profile? profile = await service.signUpWithEmailPassword(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                _username.text.trim());
            ProfileProvider provider =
                Provider.of<ProfileProvider>(context, listen: false);
            if (profile != null) {
              provider.setProfile(profile);
              SharedPreferenceService.setProfileFromLocal(profile);
            }
            Navigator.pushReplacementNamed(context, "/onboarding");
          }
        } catch (e) {
          Navigator.pushReplacementNamed(context, "/login");
        }
      },
      child: Text(
        "Registrarse",
        style: TextStyle(
          color: font,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding get _rowlinea => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: darkfont,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "o",
                style: TextStyle(color: darkfont),
              ),
            ),
            Expanded(
              child: Divider(
                color: darkfont,
                thickness: 1,
              ),
            ),
          ],
        ),
      );

  Row get _rowiconlogin => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: onGooglePressed,
              icon: Image.asset(
                "assets/icons/google_icon.webp",
                cacheWidth: 50,
                cacheHeight: 50,
              ),
            ),
          ),
        ],
      );

  Row get _createaccount => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Accede con tu cuenta aqui:", style: TextStyle(color: darkfont)),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text("Acceder", style: TextStyle(color: blue)),
          ),
        ],
      );

  void onGooglePressed() async {
    Profile? profile = await service.nativeGoogleSignIn();
    if (profile != null) {
      ProfileProvider provider =
          Provider.of<ProfileProvider>(context, listen: false);
      provider.setProfile(profile);
      SharedPreferenceService.setProfileFromLocal(profile);
      Navigator.pushReplacementNamed(context, "/onboarding");
    }
  }

  void onFacebookPressed() {}
}
