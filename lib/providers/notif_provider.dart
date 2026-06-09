import 'package:flutter/material.dart';
import '../models/notif_model.dart';
import '../services/local_notification_service.dart';
import '../services/socket_services.dart';

class NotifProvider extends ChangeNotifier {
  final List<NotifModel> _notifList = [];
  List<NotifModel> get notifList => _notifList;

  NotifProvider(){
    SocketService.instance.socket.on(
      'announcement:receive',
      (data){

        print("PROVIDER RECEIVE");
        print(data);

        addNotif(

          'Pengumuman Baru',

          data['message'],

        );

      },

    );

  }

  void addNotif(

    String title,

    String subtitle,

  ){

    _notifList.insert(

      0,

      NotifModel(

        title: title,

        subtitle: subtitle,

        time: DateTime.now().toString(),

      ),

    );

    LocalNotificationService.showNotification(

      title: title,

      body: subtitle,

    );

    notifyListeners();

  }

}