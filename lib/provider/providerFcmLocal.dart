import 'package:flutter/material.dart';
import 'package:untitled10/model/local_database.dart';

import '../model/noti_model.dart';
class ProviderFcm with ChangeNotifier{


  List<NewsModel> newsModelFields = [];


  readNewsNotification()async{
    newsModelFields = await LocalDatabase.getAllNews();
    debugPrint("read: ${newsModelFields.length}");
notifyListeners();
  }

  deleteNotificationById(var id)async{
    await LocalDatabase.deleteNew(id);
    notifyListeners();
  }

  deleteAll()async{
    await LocalDatabase.deleteAllNews();
    notifyListeners();
  }

}