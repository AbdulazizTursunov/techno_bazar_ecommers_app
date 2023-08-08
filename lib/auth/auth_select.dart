import 'package:flutter/material.dart';
import 'package:untitled10/auth/login.dart';
import 'package:untitled10/auth/sign_up.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool isLoginPage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(isLoginPage? "login page":'sign up page'),),
        body: Column(
          children: [
            isLoginPage? LoginPage(callback: () {
              setState(() {
                isLoginPage = false;
              });
            },):SignUpPage(callback: () {
    setState(() {
    isLoginPage = true;
    });}),
          ],
        )
    );
  }
}
