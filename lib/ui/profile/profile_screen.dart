import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/ui/profile/widgets/edit_profile.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../widget/shimmer_photo.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<ProfileProvider>().currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              user!.photoURL == null
                  ? Icon(
                      Icons.account_circle,
                      size: 96.h,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 160.h,
                        width: 150.w,
                        child: CachedNetworkImage(
                            imageUrl: user.photoURL ?? '',
                            placeholder: (context, url) => const ShimmerPhoto(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                            width: 140.w,
                            fit: BoxFit.cover),
                      ),
                    ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  user.displayName ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Center(
                child: Text(
                  user.email ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(),));
                },
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                onTap: () {
                  context.read<AuthProvider>().logOut(context);
                },
                title: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red),
                ),
                trailing: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ));
  }
}
