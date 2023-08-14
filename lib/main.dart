import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/notification_services/local_notification.dart';
import 'location/google_map_provider/map_provider.dart';
import 'location/ui/location_map/current_location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  await LocalNotificationService.instance.setupLocalNotification();


  runApp(
   ChangeNotifierProvider(create: (context)=> MapProvider(),
   child:  MainApp()),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LocalDatabase.deleteAllNews();
    return  ScreenUtilInit(
      designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
        builder: (context,child){
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CurrentLocationScreen());
    }
    );
  }
}
