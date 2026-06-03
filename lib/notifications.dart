import 'package:flutter/material.dart';
import 'package:arsipku/services/socket_services.dart';

class NotificationPage extends StatefulWidget {

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() =>
      _NotificationPageState();
}

class _NotificationPageState
    extends State<NotificationPage> {

  List<String> notifications = [];

  @override
  void initState() {

    super.initState();

    SocketService.instance.socket.on(

      'announcement:receive',

      (data) {

        setState(() {

          notifications.insert(
            0,
            data['message'],
          );

        });

      },

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9F3F6),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF9F3F6),

        elevation: 0,

        centerTitle: true,

        title: const Text(

          'Notifikasi',

          style: TextStyle(

            color: Color(0xFF6D4C57),

            fontWeight:
            FontWeight.bold,

          ),

        ),

      ),

      body: notifications.isEmpty

          ? const Center(

              child: Text(
                'Belum ada notifikasi',
              ),

            )

          : ListView.builder(

              padding:
              const EdgeInsets.all(20),

              itemCount:
              notifications.length,

              itemBuilder:

                  (context,index){

                return Container(

                  margin:
                  const EdgeInsets.only(
                    bottom:15,
                  ),

                  padding:
                  const EdgeInsets.all(
                    18,
                  ),

                  decoration:
                  BoxDecoration(

                    color:
                    Colors.white,

                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                  ),

                  child: Row(

                    children:[

                      const CircleAvatar(

                        backgroundColor:
                        Color(0xFFFFF1F5),

                        child: Icon(

                          Icons.notifications,

                          color:
                          Color(
                            0xFFF48FB1,
                          ),

                        ),

                      ),

                      const SizedBox(
                        width:15,
                      ),

                      Expanded(

                        child: Text(

                          notifications[
                          index
                          ],

                        ),

                      )

                    ],

                  ),

                );

              },

            ),

    );
  }
}