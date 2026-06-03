import 'package:flutter/material.dart';
import '../models/arsip_model.dart';
import '../services/arsip_service.dart';

class ArsipProvider extends ChangeNotifier {

  final ArsipService _service = ArsipService();

  List<Arsip> _arsipList = [];

  List<Arsip> get arsipList => _arsipList;

  Future<void> loadArsip() async {

    _arsipList = await _service.getArsip();

    notifyListeners();
  }

  Future<void> tambahArsip(Arsip arsip) async {

    await _service.createArsip(

      judul: arsip.judul,
      kategori: arsip.kategori,
      tanggal: arsip.tanggal,
      deskripsi: arsip.deskripsi,

    );

    await loadArsip();
  }

  Future<void> hapusArsip(String id) async {

    await _service.deleteArsip(id);

    await loadArsip();
  }
}