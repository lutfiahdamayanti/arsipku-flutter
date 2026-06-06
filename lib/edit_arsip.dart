import 'package:flutter/material.dart';
import 'services/arsip_service.dart';
import 'models/arsip_model.dart';

class EditArsipPage extends StatefulWidget {
  final Arsip arsip;
  const EditArsipPage({super.key, required this.arsip});

  @override
  State<EditArsipPage> createState() => _EditArsipPageState();
}

class _EditArsipPageState extends State<EditArsipPage> {
  late TextEditingController judulController;
  late TextEditingController deskripsiController;
  String kategori = '';
  @override
  void initState() {
    super.initState();
    judulController =
        TextEditingController(text: widget.arsip.judul);
    deskripsiController =
        TextEditingController(text: widget.arsip.deskripsi);
    kategori = widget.arsip.kategori;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor:const Color(0xFFF9F3F6),
    appBar: AppBar(
      backgroundColor:const Color(0xFFF9F3F6),
      elevation:0,
      title: const Text(
        "Edit Arsip",
        style: TextStyle(
          color: Color(0xFF9C466E),
          fontWeight:
          FontWeight.bold,
        ),
      ),
    ),
    body:
    SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            width:
            double.infinity,
            padding:
            const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color:const Color(0xFFF4AFC8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Icon(
                  Icons.edit_document,
                  size:40,
                  color:Color(0xFF6D214F),
                ),
                const SizedBox(
                  height:15,
                ),
                Text(
                  widget.arsip.judul,
                  style:
                  const TextStyle(
                    fontSize:26,
                    fontWeight:
                    FontWeight.bold,
                    color: Color(0xFF6D214F),
                  ),
                ),
                const SizedBox(
                 height:10,
               ),

               Text(

                 widget.arsip.kategori,

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

         const Text(

           "Judul Arsip",

           style: TextStyle(

             fontWeight:
             FontWeight.bold,

           ),

         ),

         const SizedBox(
           height:8,
         ),

         TextField(

           controller:
           judulController,

           decoration:
           InputDecoration(

             filled:true,

             fillColor:
             Colors.white,

             contentPadding:
             const EdgeInsets.all(
               20,
             ),

             border:
             OutlineInputBorder(

               borderRadius:
               BorderRadius.circular(
                 20,
               ),

               borderSide:
               BorderSide.none,

             ),

           ),

         ),

         const SizedBox(
           height:25,
         ),

         const Text(

           "Deskripsi",

           style: TextStyle(

             fontWeight:
             FontWeight.bold,

           ),

         ),

         const SizedBox(
           height:8,
         ),

         TextField(

           controller:
           deskripsiController,

           maxLines:6,

           decoration:
           InputDecoration(

             filled:true,

             fillColor:
             Colors.white,

             contentPadding:
             const EdgeInsets.all(
               20,
             ),

             border:
             OutlineInputBorder(

               borderRadius:
               BorderRadius.circular(
                 20,
               ),

               borderSide:
               BorderSide.none,

             ),

           ),

         ),

         const SizedBox(
           height:40,
         ),

         SizedBox(

           width:
           double.infinity,

           height:58,

           child:
           ElevatedButton(

             onPressed: () async {

               bool result=

               await ArsipService()
               .updateArsip(

                 id:
                 widget.arsip.id,

                 judul:
                 judulController.text,

                 kategori:
                 kategori,

                 deskripsi:
                 deskripsiController.text,

               );

               if(result){

                 Navigator.pop(
                   context,
                   true,
                 );

               }

             },

             style:
             ElevatedButton.styleFrom(

               backgroundColor:
               const Color(
                 0xFF9C466E,
               ),

               shape:
               RoundedRectangleBorder(

                 borderRadius:
                 BorderRadius.circular(
                   20,
                 ),

               ),

             ),

             child:
             const Text(

               "Simpan Perubahan",

               style:
               TextStyle(

                 color:
                 Colors.white,

                 fontSize:18,

                 fontWeight:
                 FontWeight.bold,

               ),

             ),

           ),

         ),

         const SizedBox(
           height:15,
         ),

         SizedBox(

           width:
           double.infinity,

           height:58,

           child:
           ElevatedButton(

             onPressed: () async {

               bool result=

               await ArsipService()
               .deleteArsip(

                 widget.arsip.id,

               );

               if(result){

                 Navigator.pop(
                   context,
                   true,
                 );

               }

             },

             style:
             ElevatedButton.styleFrom(

               backgroundColor:
               Colors.red.shade400,

               shape:
               RoundedRectangleBorder(

                 borderRadius:
                 BorderRadius.circular(
                   20,
                 ),

               ),

             ),

             child:
             const Text(

               "Hapus Arsip",

               style:
               TextStyle(

                 color:
                 Colors.white,

                 fontWeight:
                 FontWeight.bold,

                 fontSize:18,

               ),

             ),

           ),

         )

       ],

     ),

   ),

 );

}
}