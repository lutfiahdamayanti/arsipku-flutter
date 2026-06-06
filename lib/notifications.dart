import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notif_provider.dart';

class NotificationPage extends StatelessWidget {

 const NotificationPage({super.key});

 @override
 Widget build(BuildContext context){

   final notifProvider =
       context.watch<NotifProvider>();

   return Scaffold(

     backgroundColor:
     const Color(0xFFF9F3F6),

     appBar: AppBar(

       backgroundColor:
       const Color(0xFFF9F3F6),

       title: const Text(
         "Notifikasi",
       ),

     ),

     body:

     notifProvider.notifList.isEmpty

     ? const Center(

         child:
         Text(
           "Belum ada notifikasi",
         ),

       )

     :

     ListView.builder(

       itemCount:
       notifProvider.notifList.length,

       itemBuilder:(context,index){

         final notif =
             notifProvider.notifList[index];

         return ListTile(

           leading:
           const Icon(
             Icons.notifications,
           ),

           title:
           Text(
             notif.title,
           ),

           subtitle:
           Text(
             notif.subtitle,
           ),

         );

       },

     ),

   );

 }

}