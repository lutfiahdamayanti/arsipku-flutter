import 'package:flutter/material.dart';

class DetailArsipPage extends StatelessWidget {

  final Map arsip;

  const DetailArsipPage({

    super.key,

    required this.arsip,

  });

  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor:
      const Color(0xFFF9F3F6),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF9F3F6),

        elevation: 0,

        title: const Text(

          "Detail Arsip",

          style: TextStyle(

            color:
            Color(0xFF9C466E),

            fontWeight:
            FontWeight.bold,

          ),

        ),

      ),

      body:

      SingleChildScrollView(

        padding:
        const EdgeInsets.all(24),

        child:

        Column(

          children:[

            /// HEADER CARD

            Container(

              width:
              double.infinity,

              padding:
              const EdgeInsets.all(28),

              decoration:
              BoxDecoration(

                color:
                const Color(
                  0xFFF4AFC8,
                ),

                borderRadius:
                BorderRadius.circular(
                  30,
                ),

              ),

              child:

              Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children:[

                  const Icon(

                    Icons.folder_copy,

                    color:
                    Color(
                      0xFF6D214F,
                    ),

                    size:40,

                  ),

                  const SizedBox(
                    height:20,
                  ),

                  Text(

                    arsip['judul'],

                    style:
                    const TextStyle(

                      fontSize:28,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Color(
                        0xFF6D214F,
                      ),

                    ),

                  ),

                  const SizedBox(
                    height:10,
                  ),

                  Text(

                    arsip['kategori'],

                    style:
                    const TextStyle(

                      color:
                      Color(
                        0xFF6D214F,
                      ),

                    ),

                  )

                ],

              ),

            ),

            const SizedBox(
              height:30,
            ),

            _detailCard(

              icon:
              Icons.category,

              title:
              "Kategori",

              value:
              arsip['kategori'],

            ),

            const SizedBox(
              height:18,
            ),

            _detailCard(

              icon:
              Icons.calendar_month,

              title:
              "Tanggal",

              value:
              arsip['tanggal'],

            ),

            const SizedBox(
              height:18,
            ),

            _detailCard(

              icon:
              Icons.description,

              title:
              "Deskripsi",

              value:
              arsip['deskripsi'],

            ),

          ],

        ),

      ),

    );

  }

}

Widget _detailCard({

 required IconData icon,

 required String title,

 required String value,

}){

 return Container(

   width:
   double.infinity,

   padding:
   const EdgeInsets.all(
     20,
   ),

   decoration:
   BoxDecoration(

     color:
     Colors.white,

     borderRadius:
     BorderRadius.circular(
       25,
     ),

     boxShadow:[

       BoxShadow(

         color:
         Colors.black.withOpacity(
           0.05,
         ),

         blurRadius:10,

       )

     ],

   ),

   child:

   Row(

     crossAxisAlignment:
     CrossAxisAlignment.start,

     children:[

       CircleAvatar(

         radius:24,

         backgroundColor:
         const Color(
           0xFFFFEEF4,
         ),

         child:

         Icon(

           icon,

           color:
           const Color(
             0xFF9C466E,
           ),

         ),

       ),

       const SizedBox(
         width:15,
       ),

       Expanded(

         child:

         Column(

           crossAxisAlignment:
           CrossAxisAlignment.start,

           children:[

             Text(

               title,

               style:
               const TextStyle(

                 fontWeight:
                 FontWeight.bold,

                 color:
                 Color(
                   0xFF9C466E,
                 ),

               ),

             ),

             const SizedBox(
               height:6,
             ),

             Text(
               value,
             )

           ],

         ),

       )

     ],

   ),

 );

}