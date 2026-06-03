class Arsip {
  final String id;
  final String judul;
  final String kategori;
  final String tanggal;
  final String deskripsi;

  Arsip({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.tanggal,
    required this.deskripsi,
  });

  factory Arsip.fromJson(Map<String, dynamic> json) {
    return Arsip(
      id: json['id'].toString(),
      judul: json['judul'],
      kategori: json['kategori'],
      tanggal: json['tanggal'],
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}