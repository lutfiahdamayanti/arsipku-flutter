import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Color(0xFF6D4C57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _notifCard(
            title: 'Arsip berhasil ditambahkan',
            subtitle: 'Notulensi Rapat HIMA telah tersimpan',
            icon: Icons.check_circle_outline,
          ),

          const SizedBox(height: 15),

          _notifCard(
            title: 'Surat Masuk Baru',
            subtitle: 'Undangan Seminar Nasional',
            icon: Icons.mail_outline,
          ),

          const SizedBox(height: 15),

          _notifCard(
            title: 'Arsip diperbarui',
            subtitle: 'Proposal Kegiatan telah diedit',
            icon: Icons.edit_outlined,
          ),

          const SizedBox(height: 15),

          _notifCard(
            title: 'Backup berhasil',
            subtitle: 'Data arsip berhasil dicadangkan',
            icon: Icons.backup_outlined,
          ),
        ],
      ),
    );
  }

  Widget _notifCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: const Color(0xFFFFF1F5),
            child: Icon(
              icon,
              color: const Color(0xFFF48FB1),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6D4C57),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}