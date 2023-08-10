import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/model/noti_model.dart';
import 'package:untitled10/provider/providerFcmLocal.dart';
import '../notification_services/fcm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification>
    with WidgetsBindingObserver {
  @override
  void initState() {
    initFirebase(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          TextButton(
              onPressed: () {
                FirebaseMessaging.instance.subscribeToTopic("news");
              },
              child: Text("ON")),
        ],),
        body: context.watch<ProviderFcm>().newsModelFields.isEmpty
            ? const Center(child: Text("EMPTY  EMAIL"))
            : Consumer<ProviderFcm>(builder: (context, provider, child) {
              provider.readNewsNotification();
                return ListView(
                  children: [
                    ...List.generate(
                      provider.newsModelFields.length,
                      (index) {
                        final s = provider.newsModelFields;
                        NewsModel newsModel = s [index] ;
                        debugPrint(
                            s.length.toString());
                        return ListTile(
                          onLongPress: (){
                            provider.deleteNotificationById(newsModel.id);
                          },
                          leading: Image.network(newsModel.newsDataImg),
                          title: Text(newsModel.newsTitle),
                          subtitle: Text(
                            newsModel.newsBody,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
      );

  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        context.read<ProviderFcm>().readNewsNotification();
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
    }
  }
}
