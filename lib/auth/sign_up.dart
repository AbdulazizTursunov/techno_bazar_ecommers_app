import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/utils/size_box_extension.dart';

import '../provider/auth_provider.dart';
import '../widget/global_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, required this.callback}) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            TextField(
              controller: context.read<AuthProvider>().userNameController,

              textInputAction: TextInputAction.next,
              decoration:InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "user name",
                prefixIcon: Icon(Icons.text_fields_outlined),
                hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing:1,fontSize: 16,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(width: 1, ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,

                  ),
                ),
              ),
            ),20.ph,
            TextField(
              controller: context.read<AuthProvider>().emailController,

              textInputAction: TextInputAction.next,
              decoration:InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "email",
                prefixIcon: Icon(Icons.email),
                hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing:1,fontSize: 16,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(width: 1, ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,

                  ),
                ),
              ),
            ),20.ph,
            TextField(
              textInputAction: TextInputAction.done,

              controller: context.read<AuthProvider>().passwordController,

              decoration:InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "password",
                prefixIcon: Icon(Icons.lock),
                hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing:1,fontSize: 16,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(width: 1, ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    width: 1,

                  ),
                ),
              ),
            ),
          20.ph,
            GlobalButton(title: "Sign Up", onTap: (){
              context.read<AuthProvider>().signUpUser(context);
            }),

            TextButton(
              onPressed: () {
                callback.call();
                context.read<AuthProvider>().signUpButtonPressed();
              },
              child: Text("Login"),
            ),

           30.ph,
            TextButton(
              onPressed: () {
                context.read<AuthProvider>().signInWithGoogle(context);
              },
              child: Text("google"),
            ),
          ],
        ),
      ),
    );
  }
}
