import 'package:dietify/domain/models/profile.dart';
import 'package:dietify/data/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/providers/profile_provider.dart';
import '../../../data/service/shared_preference_service.dart';
import '../../widgets/form_widget.dart';
import '../../widgets/splash_page.dart';
import 'sign_up_page.dart';
import '../../../../../utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AuthService service;
  late ProfileProvider profileProvider;
  final _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

  @override
  Widget build(BuildContext context) {
    service = Provider.of<AuthService>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bienvenido de vuelta",
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
                  } else if (value.length < 6) {
                    return "Debe contener al menos 6 caracteres";
                  } else if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "La contraseña debe contener al menos una mayuscula";
                  } else if (!value.contains(RegExp(r'[0-9]'))) {
                    return "La contraseña debe contener un numero";
                  } else if (!_passwordRegex.hasMatch(value)) {
                    return 'Incluir una letra y un número';
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: _buttonLogin(context),
              ),
              _rowlinea,
              _rowiconlogin,
              _createaccount,
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buttonLogin(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(blue),
        minimumSize: WidgetStateProperty.all(Size(300, 50)),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Profile? profile = await service.signInWithEmailPassword(
              _emailController.text.trim(), _passwordController.text.trim());
          if (profile != null) {
            ProfileProvider provider =
                Provider.of<ProfileProvider>(context, listen: false);
            provider.setProfile(profile);
            SharedPreferenceService.setProfileFromLocal(profile);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SplashScreen(route: "/home", seconds: 3),
                ));
          }
        }
      },
      child: Text(
        "Acceder",
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
              onPressed: onGooglePresed,
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
          Text(
            "Crea tu cuenta aqui:",
            style: TextStyle(color: darkfont),
          ),
          TextButton(
            onPressed: onCreatePressed,
            child: Text(
              "Registrar",
              style: TextStyle(color: blue),
            ),
          ),
        ],
      );

  void onGooglePresed() async {
    Profile? profile = await service.nativeGoogleSignIn();
    if (profile != null) {
      ProfileProvider provider =
          Provider.of<ProfileProvider>(context, listen: false);
      provider.setProfile(profile);
      SharedPreferenceService.setProfileFromLocal(profile);
      Navigator.pushReplacementNamed(context, "/onboarding");
    }
  }

  void onFacebookPresed() {}

  void onCreatePressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }
}
