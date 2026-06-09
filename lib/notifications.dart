import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notif_provider.dart';

class NotificationPage extends StatelessWidget {

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final notifProvider =
        context.watch<NotifProvider>();

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9F3F6),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF9F3F6),

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "Notifikasi",

          style: TextStyle(

            color: Color(0xFF6D4C57),

            fontWeight: FontWeight.bold,

            fontSize: 24,

          ),

        ),

      ),

      body:

      notifProvider.notifList.isEmpty

      ? Center(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: const [

              Icon(

                Icons.notifications_off_outlined,

                size: 70,

                color: Color(0xFFD6A5B8),

              ),

              SizedBox(height: 15),

              Text(

                "Belum ada notifikasi",

                style: TextStyle(

                  fontSize: 18,

                  color: Color(0xFF6D4C57),

                  fontWeight: FontWeight.w600,

                ),

              ),

            ],

          ),

        )

      :

      ListView.builder(

        padding:
        const EdgeInsets.all(20),

        itemCount:
        notifProvider.notifList.length,

        itemBuilder:(context,index){

          final notif =
          notifProvider.notifList[index];

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
              const Color(
                0xFFFFFCFD,
              ),

              borderRadius:
              BorderRadius.circular(
                24,
              ),

              boxShadow:[

                BoxShadow(

                  color:
                  Colors.black.withOpacity(
                    0.05,
                  ),

                  blurRadius:10,

                  offset:
                  const Offset(
                    0,
                    4,
                  ),

                )

              ],

            ),

            child: Row(

              children:[

                Container(

                  padding:
                  const EdgeInsets.all(
                    12,
                  ),

                  decoration:
                  const BoxDecoration(

                    color:
                    Color(
                      0xFFFFEEF4,
                    ),

                    shape:
                    BoxShape.circle,

                  ),

                  child: const Icon(

                    Icons.notifications,

                    color:
                    Color(
                      0xFFB04C7A,
                    ),

                  ),

                ),

                const SizedBox(
                  width:15,
                ),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children:[

                      Text(

                        notif.title,

                        style:
                        const TextStyle(

                          fontWeight:
                          FontWeight.bold,

                          fontSize:16,

                          color:
                          Color(
                            0xFF6D4C57,
                          ),

                        ),

                      ),

                      const SizedBox(
                        height:5,
                      ),

                      Text(

                        notif.subtitle,

                        style:
                        const TextStyle(

                          color:
                          Colors.grey,

                        ),

                      ),

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