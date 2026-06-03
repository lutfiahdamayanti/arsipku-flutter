import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/arsip_model.dart';

class ArsipService {

  static const String baseUrl =
      'http://192.168.1.7/arsipku_backend'; // Ganti sesuai IP server lokal masing-masing

  Future<List<Arsip>> getArsip() async {
    final response = await http.get(
      Uri.parse('$baseUrl/read.php'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data
          .map((e) => Arsip.fromJson(e))
          .toList();
    }
    throw Exception('Gagal mengambil data');
  }

  Future<bool> createArsip({
  required String judul,
  required String kategori,
  required String tanggal,
  required String deskripsi,

}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      body: {
        'judul': judul,
        'kategori': kategori,
        'tanggal': tanggal,
        'deskripsi': deskripsi,
      },
    );
    print("RESPONSE BODY:");
    print(response.body);

    final data = jsonDecode(response.body);
    return data['success'] == true;

  } catch (e) {
    print("ERROR CREATE ARSIP: $e");
    return false;
  }
}

  Future<bool> updateArsip({
    required String id,
    required String judul,
    required String kategori,
    required String deskripsi,

  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update.php'),
      body: {
        'id': id,
        'judul': judul,
        'kategori': kategori,
        'deskripsi': deskripsi,
      },
    );
    final data = jsonDecode(response.body);
    return data['success'];
  }

  Future<bool> deleteArsip(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      body: {
        'id': id,
      },
    );

    final data = jsonDecode(response.body);
    return data['success'] == true;
  }
}