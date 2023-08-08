import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, required this.ontap, required this.title, required this.height, required this.width});

  final VoidCallback ontap;
  final String title;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.yellow),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.r)
                )
            )
        ),
        onPressed: ontap,
        child: Text(title,style: const TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.w700)),
      ),
    );
  }
}
