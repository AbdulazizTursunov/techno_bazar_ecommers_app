import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );

  static ThemeData myTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(size: 30.sp),
      backgroundColor: AppColors.c_111015,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(color: Colors.yellow)
    ),
    appBarTheme: AppBarTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 30.sp,
      fontWeight: FontWeight.w600,
      color: Colors.yellow,
      fontFamily: "Montserrat"
      ),
      backgroundColor: AppColors.c_111015,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.c_111015,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'colors/app_colors.dart';
//
// class AppTheme{
//   static ThemeData lightTheme=ThemeData(
//       scaffoldBackgroundColor: AppColors.white,
//       appBarTheme:  AppBarTheme(
//           elevation: 0,
//           backgroundColor: AppColors.white,
//           systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarColor: AppColors.white,
//               statusBarBrightness: Brightness.dark,
//               statusBarIconBrightness: Brightness.dark
//           )
//       ),
//       textTheme:  TextTheme(
//         //display
//           displayLarge: TextStyle(
//               color: AppColors.black,
//               fontSize: 57.sp,
//               fontWeight: FontWeight.w800,
//               fontFamily: 'Capriola'
//           ),
//           displayMedium: TextStyle(
//               color: AppColors.black,
//               fontSize: 45.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Capriola'
//           ),
//           displaySmall: TextStyle(
//               color: AppColors.black,
//               fontSize: 36.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           //headline
//           headlineLarge: TextStyle(
//               color: AppColors.black,
//               fontSize: 32.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Capriola'
//           ),
//           headlineMedium: TextStyle(
//               color: AppColors.black,
//               fontSize: 28.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           headlineSmall: TextStyle(
//               color: AppColors.black,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'Capriola'
//           ),
//           //title
//           titleLarge: TextStyle(
//               color: AppColors.black,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           titleMedium: TextStyle(
//               color: AppColors.black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           titleSmall: TextStyle(
//               color: AppColors.black,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           //label
//           labelLarge: TextStyle(
//               color: AppColors.black,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           labelMedium: TextStyle(
//               color: AppColors.black,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           labelSmall: TextStyle(
//               color: AppColors.black,
//               fontSize: 11.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           //body
//           bodyLarge: TextStyle(
//               color: AppColors.black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           bodyMedium: TextStyle(
//               color: AppColors.black,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           bodySmall: TextStyle(
//               color: AppColors.black,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           )
//
//       )
//   );
//
//   static ThemeData darkTheme=ThemeData(
//       scaffoldBackgroundColor: AppColors.black,
//       appBarTheme:  AppBarTheme(
//           backgroundColor: AppColors.black,
//           systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarColor: AppColors.black,
//               statusBarBrightness: Brightness.light,
//               statusBarIconBrightness: Brightness.light
//           )
//       ),
//       textTheme:  TextTheme(
//         //display
//           displayLarge: TextStyle(
//               color: AppColors.white,
//               fontSize: 57.sp,
//               fontWeight: FontWeight.w800,
//               fontFamily: 'Capriola'
//           ),
//           displayMedium: TextStyle(
//               color: AppColors.white,
//               fontSize: 45.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Capriola'
//           ),
//           displaySmall: TextStyle(
//               color: AppColors.white,
//               fontSize: 36.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           //headline
//           headlineLarge: TextStyle(
//               color: AppColors.white,
//               fontSize: 32.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Capriola'
//           ),
//           headlineMedium: TextStyle(
//               color: AppColors.white,
//               fontSize: 28.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           headlineSmall: TextStyle(
//               color: AppColors.white,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'Capriola'
//
//           ),
//           //title
//           titleLarge: TextStyle(
//               color: AppColors.white,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           titleMedium: TextStyle(
//               color: AppColors.white,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           titleSmall: TextStyle(
//               color: AppColors.white,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           //label
//           labelLarge: TextStyle(
//               color: AppColors.white,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Capriola'
//           ),
//           labelMedium: TextStyle(
//               color: AppColors.white,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           labelSmall: TextStyle(
//               color: AppColors.white,
//               fontSize: 11.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           //body
//           bodyLarge: TextStyle(
//               color: AppColors.white,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           bodyMedium: TextStyle(
//               color: AppColors.white,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           ),
//           bodySmall: TextStyle(
//               color: AppColors.white,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Capriola'
//           )
//
//       )
//   );
// }
