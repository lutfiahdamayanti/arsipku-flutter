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
      backgroundColor: const Color(0xFFF9F3F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        title: const Text(
          'Edit Arsip',
          style: TextStyle(
            color: Color(0xFF6D4C57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul Arsip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6D4C57),
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: judulController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Deskripsi',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6D4C57),
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: deskripsiController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  bool result =
                  await ArsipService().updateArsip(
                    id: widget.arsip.id,
                    judul: judulController.text,
                    kategori: kategori,
                    deskripsi: deskripsiController.text,
                  );
                  if (result) {
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF48FB1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                 ),
               ),

               child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
               ),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  bool result =
                  await ArsipService().deleteArsip(
                    widget.arsip.id,
                  );

                  if (result) {
                   Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Hapus Arsip",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}