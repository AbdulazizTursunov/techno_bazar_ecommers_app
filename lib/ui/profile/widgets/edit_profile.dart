import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/ui/profile/widgets/update_button.dart';

import '../../../../provider/profile_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../widget/GlobalTextField.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _imageUrl;
  File? image;

  Future picker(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String?> uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(File(imageFile.path));

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _uploadImage() async {
    String? downloadUrl = await uploadImageToFirebase(image);
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.r),
        child: SizedBox(
          height: 50.h,
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(AppColors.c_111015),
            ),
            onPressed: () {
              _uploadImage();
              context
                  .read<ProfileProvider>()
                  .updateAll(context, _imageUrl ?? '');
            },
            child: const Text("Update All",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(children: [
                  Expanded(
                    child: GlobalTextField(
                      hintText: "Display Name",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller:
                          context.read<ProfileProvider>().nameController,
                      icon: Icons.person,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: UpdateButton(
                      ontap: () {
                        _uploadImage();
                        context.read<ProfileProvider>().updateUserDisplayName(context);
                      },
                      title: "Update Name",
                      height: 65,
                      width: 80,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GlobalTextField(
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        controller:
                            context.read<ProfileProvider>().emailController,
                        icon: Icons.email,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: UpdateButton(
                          height: 65,
                          width: 80,
                          ontap: () {
                            _uploadImage();
                            context
                                .read<ProfileProvider>()
                                .updateEmail(context);
                          },
                          title: 'Update Email'),
                    )
                  ],
                ),
                image == null
                    ? const Text('')
                    : Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                            width: 150.w,
                            height: 150.h,
                            child: Image.file(
                              image!,
                              fit: BoxFit.fill,
                            )),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: UpdateButton(
                          ontap: () {
                            picker(ImageSource.gallery);
                          },
                          title: 'Select image',
                          height: 40,
                          width: 160),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: UpdateButton(
                          ontap: () {
                            picker(ImageSource.camera);
                          },
                          title: 'Select camera',
                          height: 40,
                          width: 160),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.yellow)),
                    onPressed: () {
                      _uploadImage();
                      context
                          .read<ProfileProvider>()
                          .updateUserImage(context, _imageUrl ?? '');
                    },
                    child: const Text("Update image",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
