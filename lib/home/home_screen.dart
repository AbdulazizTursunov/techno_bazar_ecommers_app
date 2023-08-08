import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().logOut(context);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Text("xush kelding"),
    );
  }
}
