import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/data/firebase/profile_service.dart';

import '../data/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({required this.profileService}) {
    currentUser = FirebaseAuth.instance.currentUser;
    listenUserChanges();
    notifyListeners();
  }

  final ProfileService profileService;

  bool isLoading = true;
  User? currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }


  Future<void> updateEmail(BuildContext context) async {
    debugPrint("UPDATE USER EMAIL");
    String emailAddress = emailController.text;
    if (emailAddress.isNotEmpty) {
      showLoading(context: context);
      debugPrint("UPDATE USER EMAIL IF ICHI");
      UniversalData universalData =
          await profileService.updateUserEmail(email: emailAddress);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          manageMessage(context, universalData.data as String);
        } else {
          if (context.mounted) {
            manageMessage(context, universalData.error);
          }
        }
      }
    }
  }

  Future<void> updateUserDisplayName(BuildContext context) async {
    debugPrint("UPDATE USER NAME");
    String name = nameController.text;
    notifyListeners();
    if (name.isNotEmpty) {
      debugPrint("UPDATE USER NAME if ichi");
      debugPrint("${nameController.text}");
      showLoading(context: context);
      UniversalData universalData =
      await profileService.updateUserName(name: name );
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          manageMessage(context, universalData.data as String);
        } else {
          if (context.mounted) {
            manageMessage(context, universalData.error);
          }
        }
      }
    }
  }


  Future<void> updateUserImage(BuildContext context, String imagePath) async {
    showLoading(context: context);
    UniversalData universalData =
    await profileService.updateUserImage(imagePath: imagePath);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        manageMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        manageMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateAll(BuildContext context,String imagePath) async {
    String name = nameController.text;
    String email = emailController.text;

    if(name.isNotEmpty){

      if(email.isNotEmpty){
        await updateEmail(context);
        if(imagePath.isNotEmpty){
          if(context.mounted) {
            showLoading(context: context);
          }
          UniversalData universalData = await profileService.updateAll(imagePath: imagePath, username: name, email: email);
          if(context.mounted) {
            hideLoading(dialogContext: context);
          }
        }else{
          if (context.mounted) {
            manageMessage(context, 'Image empty');
          }
        }
      }else{
        if (context.mounted) {
          manageMessage(context, 'Email empty');
        }
      }
    }else{
      if (context.mounted) {
        manageMessage(context, 'Name empty');
      }
    }

    // if (name.isNotEmpty) {
    //
    //   if (email.isNotEmpty&&name.isNotEmpty) {
    //     if (universalData.error.isEmpty) {
    //       if (context.mounted) {
    //         showMessage(context, universalData.data as String);
    //       }
    //     } else {
    //       if (context.mounted) {
    //         showMessage(context, universalData.error);
    //       }
    //     }
    //     if (imagePath.isNotEmpty) {
    //       UniversalData
    //       if(context.mounted) {
    //         Navigator.pop(context);
    //       }
    //       if (universalData.error.isEmpty) {
    //         if (context.mounted) {
    //           showMessage(context, universalData.data as String);
    //         }
    //       } else {
    //         if (context.mounted) {
    //           showMessage(context, universalData.error);
    //         }
    //       }
    //     }
    //   }else{
    //     if (context.mounted) {
    //       showMessage(context, 'Email empty');
    //     }
    //   }
    //   UniversalData
    //   if (universalData.error.isEmpty) {
    //     if (context.mounted) {
    //       showMessage(context, universalData.data as String);
    //     }
    //   } else {
    //     if (context.mounted) {
    //       showMessage(context, universalData.error);
    //     }
    //   }
    //
    //   if(context.mounted) {
    //     hideLoading(dialogContext: context);
    //   }
    // }else{
    //   if (context.mounted) {
    //     showMessage(context, 'Name empty');
    //   }
    // }
    //


  }


  manageMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }
}
