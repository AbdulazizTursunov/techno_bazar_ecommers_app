import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled10/data/firebase/auth_service.dart';
import 'package:untitled10/data/universal_data.dart';
import 'package:untitled10/utils/ui_utils/error_messaga_dialog.dart';
import 'package:untitled10/utils/ui_utils/loading_dialog.dart';

class AuthProvider with ChangeNotifier {
  AuthService firabaseService;

  AuthProvider({required this.firabaseService});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  loginButtonPressed() {
    passwordController.clear();
    emailController.clear();
    userNameController.clear();
  }

  signUpButtonPressed() {
    passwordController.clear();
    emailController.clear();
  }

  Stream<User?> listenUser() => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpUser(BuildContext context) async {
    String emailAddress = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);

    UniversalData universalData = await firabaseService.signUpUser(
        emailAddress: emailAddress, password: password);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    if(universalData.error.isEmpty){
      if(context.mounted){
        showConfirmMessage(message:"user signed up"  , context: context);

      }else{
        if(context.mounted){
          showErrorMessage(message:universalData.error , context: context);
        }
      }
    }
  }

  Future<void> signInUser(BuildContext context) async {
    String emailAddress = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData = await firabaseService.signInUser(emailAddress: emailAddress, password: password);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }    if(universalData.error.isEmpty){
      if(context.mounted){
        showConfirmMessage(message:"user signed in"  , context: context);

      }else{
        if(context.mounted){
          showErrorMessage(message:universalData.error  , context: context);
        }
      }
    }
  }


  Future<void> logOut(BuildContext context) async {

    showLoading(context: context);
    UniversalData universalData = await firabaseService.logOutUser();
    if(context.mounted){
      hideLoading(dialogContext: context);
    }
    if(universalData.error.isEmpty){
      if(context.mounted){
        showConfirmMessage(message: universalData.data as String  , context: context);
      }else{
        if(context.mounted){
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    }
  }



Future<void> signInWithGoogle (BuildContext context) async{
  showLoading(context: context);
  UniversalData universalData = await firabaseService.signInWithGoogle();
if(context.mounted){
  hideLoading(dialogContext: context);
}
  if(universalData.error.isEmpty){
    if(context.mounted){
      showConfirmMessage(message:  "user sign in with google", context: context);
    }else{
      if(context.mounted){
        showErrorMessage(message: universalData.error , context: context);
      }
    }
  }
}

}
