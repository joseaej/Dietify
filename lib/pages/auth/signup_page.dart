// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:Dietify/pages/auth/auth_viewmodel.dart';
import 'package:Dietify/widgets/formWidget.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';
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
  bool seePassword = true;

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create your account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            form(
              _emailController,
              "Email",
              Icon(Icons.email,color: orange,),
              inputBorder,
              EdgeInsets.fromLTRB(50, 30, 50, 20),
              isPassword: false,
            ),form(
              _username,
              "Usuario",
              Icon(Icons.person,color: orange,),
              inputBorder,
              EdgeInsets.fromLTRB(50, 10, 50, 20),
              isPassword: false,
            ),form(
              _passwordController,
              "Password",
              Icon(Icons.lock_outline_rounded,color: orange,),
              inputBorder,
              EdgeInsets.fromLTRB(50, 10, 50, 20),
              isPassword: true,
            ),
            form(
              _confirmpassController,
              "Confirm Password",
              Icon(Icons.lock_outline_rounded,color: orange,),
              inputBorder,
              EdgeInsets.fromLTRB(50, 10, 50, 20),
              isPassword: true,
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
    );
  }


  TextButton _buttonSignUp(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(orange),
        minimumSize: WidgetStateProperty.all(Size(300, 50)),
      ),
      onPressed: () async {

        if (_passwordController.text != _confirmpassController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }

        try {
          await AuthViewmodel.registerUser(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _username.text.trim(),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${AuthViewmodel.error}')),
          );
        }
      },
      child: Text(
        "Sign Up",
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
            "or",
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
    /*
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
        onPressed: onGooglePressed,
        icon: Image.asset("assets/images/google_icon.webp"),
      ),
      IconButton(
        onPressed: onFacebookPressed,
        icon: Image.asset("assets/images/facebook_icon.webp"),
      ),
    ],*/
  );

  Row get _createaccount => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Access with your account here:", style: TextStyle(color: darkfont)),
      TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text("Login", style: TextStyle(color: orange)),
      ),
    ],
  );

  void onGooglePressed() {
    // Handle Google login
  }

  void onFacebookPressed() {
    // Handle Facebook login
  }
}