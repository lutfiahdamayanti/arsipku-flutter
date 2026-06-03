import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arsipku/services/arsip_service.dart';
import 'package:file_picker/file_picker.dart';

class TambahArsipPage extends StatefulWidget {
  const TambahArsipPage({super.key});

  @override
  State<TambahArsipPage> createState() => _TambahArsipPageState();
}

class _TambahArsipPageState extends State<TambahArsipPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  File? file;
  String? fileName;

  String kategori = 'Notulensi Rapat';

  final List<String> kategoriList = [
    'Surat Masuk',
    'Surat Keluar',
    'Notulensi Rapat',
    'Proposal',
    'LPJ',
    'Dokumentasi',
  ];

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  );

  if (result != null) {
    setState(() {
      file = File(result.files.single.path!);
      fileName = result.files.single.name;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        title: const Text(
          'Tambah Arsip',
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
              'Kategori',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6D4C57),
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField(
              value: kategori,
              items: kategoriList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  kategori = value!;
                });
              },
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

            const SizedBox(height: 20),

            const Text(
              'Tanggal',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6D4C57),
              ),
            ),

          const SizedBox(height: 8),
          TextField(
            controller: tanggalController,
            decoration: InputDecoration(
              hintText: '2025-06-18',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

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
              maxLines: 4,
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

            InkWell(
              onTap: pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFF8BBD0),
                  ),
                ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.upload_file_rounded,
                        color: Color(0xFFF48FB1), size: 40,
                      ),
                      const SizedBox(height: 8),
                      const Text('Pilih File (PDF /Gambar)'),
              
                      if (fileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                          child: Text(
                          fileName!, style: const TextStyle(color: Colors.green),
                      ),
                      )
                    ],
                  ),
                ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  try {
    bool berhasil = await ArsipService().createArsip(
      judul: judulController.text,
      kategori: kategori,
      tanggal: tanggalController.text,
      deskripsi: deskripsiController.text,
    );

    if (berhasil) {
      judulController.clear();
      deskripsiController.clear();
      tanggalController.clear();

      setState(() {
        file = null;
        fileName = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Arsip berhasil disimpan')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan arsip')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF48FB1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Simpan Arsip',
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