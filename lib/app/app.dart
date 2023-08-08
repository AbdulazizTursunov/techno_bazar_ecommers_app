import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/auth/auth_select.dart';
import 'package:untitled10/ui/tab_box_client/tab_box_client.dart';
import 'package:untitled10/utils/constant.dart';

import '../provider/auth_provider.dart';
import '../ui/tab_box_admin/tab_box_admin.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            print("auth screen");
            return const AuthScreen();
          } else {
            return snapshot.data!.email==emailAdmin?TabBoxAdmin():TabBoxClient();
          }
        },
      ),
    );
  }
}
