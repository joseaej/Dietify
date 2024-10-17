// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:dietify/AuthPages/stiles_login.dart';
import 'package:dietify/home.dart';
import 'package:dietify/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SingUpScreen(),
    );
  }
}

class _SingUpScreenState extends State<SingUpScreen> {
  User? user;

  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(66.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 200,
            ),
            Text(
              "Dietify",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(226, 219, 122, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_outlined),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F5DC),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.0),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        height: 60,
                        child: TextField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F5DC),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        height: 60,
                        child: TextField(
                          controller: _confirmPassController,
                          obscureText: !_confirmPassVisible,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Contraseña',
                            prefixIcon: Icon(Icons.lock_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F5DC),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 20.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPassVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  
                                  _confirmPassVisible = !_confirmPassVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    _SingIN();
                  },
                  child: Text('Acceder'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _SingUP(),
                  child: Text('Registrarse'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _SingUP() async {
    String email = _emailController.text;
    String confirmPassword = _confirmPassController.text;
    String password = _passwordController.text;
    if (confirmPassword == password) {
      user = await AuthService().registerAccount(email, password);

      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      } else {
        print("ERROR");
      }
    } else {
      print("Las contraseñas no coinciden");
    }
  }

  void _SingIN() async {
    String email = _confirmPassController.text;
    String password = _passwordController.text;

    user = await AuthService().singInAccount(email, password);

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } else {
      print("ERROR");
    }
  }
}
