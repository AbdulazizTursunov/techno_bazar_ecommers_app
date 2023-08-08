import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled10/app/app.dart';
import 'package:untitled10/data/firebase/auth_service.dart';
import 'package:untitled10/data/firebase/category_service.dart';
import 'package:untitled10/data/firebase/order_service.dart';
import 'package:untitled10/data/firebase/product_service.dart';
import 'package:untitled10/data/firebase/profile_service.dart';
import 'package:untitled10/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/provider/category_provider.dart';
import 'package:untitled10/provider/order_provider.dart';
import 'package:untitled10/provider/product_provider.dart';
import 'package:untitled10/provider/profile_provider.dart';
import 'package:untitled10/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(firabaseService: AuthService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(profileService: ProfileService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(categoryService: CategoryService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(productService: ProductService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(orderService:OrderService()),
          lazy: true,
        ),
      ],
      child:const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
        builder: (context,child){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.myTheme,
            home:const App());
    }
    );
  }
}
