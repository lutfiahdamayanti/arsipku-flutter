import 'package:flutter/material.dart';
import 'package:arsipku/home.dart';
import 'package:arsipku/profil.dart';
import 'package:arsipku/tambah_arsip.dart';
import 'package:arsipku/notifications.dart';
import 'package:arsipku/models/arsip_model.dart';
// import 'package:arsipku/services/arsip_service.dart';
import 'package:arsipku/edit_arsip.dart';
import 'package:provider/provider.dart';
import 'providers/arsip_provider.dart';

class ArsipPage extends StatefulWidget {
  const ArsipPage({super.key});

  @override
  State<ArsipPage> createState() => _ArsipPageState();
}

class _ArsipPageState extends State<ArsipPage> {
  int selectedIndex = 0;

  String kategoriTerpilih = 'Semua';
  String keyword = '';

  final List<String> kategori = [
    'Semua',
    'Surat Masuk',
    'Surat Keluar',
    'Notulensi Rapat',
    'Proposal',
    'LPJ',
    'Dokumentasi',
  ];

  // int totalArsip = 0;
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ArsipProvider>().loadArsip();
    });
  }
  // Future<void> loadTotalArsip() async {
  //   final data = await ArsipService().getArsip();
  //   setState(() {
  //     totalArsip = data.length;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'ArsipKu',
          style: TextStyle(
            color: Color(0xFF9C466E),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFF8BBD0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                }, 
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xFF6D4C57),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9C466E),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahArsipPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // SEARCH
            TextField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari arsip...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF9C466E),
                ),
                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KATEGORI
            SizedBox(
              height: 45,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: kategori.length,
                itemBuilder: (context, index) {
                  bool selected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          kategoriTerpilih = kategori[index];
                        });
                      },

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF9C466E)
                              : const Color(0xFFF7DCE6),

                          borderRadius: BorderRadius.circular(25),
                        ),

                        child: Text(
                          kategori[index],

                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : const Color(0xFF6D4C57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // PRIORITAS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: const Color(0xFFF4AFC8),
                borderRadius: BorderRadius.circular(30),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star_border,
                    color: Color(0xFF6D214F),
                    size: 30,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Ringkasan Arsip',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D214F),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    '${context.watch<ArsipProvider>().arsipList.length} dokumen tersimpan dalam arsip.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6D214F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
  child: Consumer<ArsipProvider>(
    builder: (context, provider, child) {

      final arsipList = provider.arsipList;

      List<Arsip> filteredList = arsipList;

      if (kategoriTerpilih != 'Semua') {
        filteredList = filteredList.where((arsip) {
          return arsip.kategori == kategoriTerpilih;
        }).toList();
      }

      if (keyword.isNotEmpty) {
        filteredList = filteredList.where((arsip) {
          return arsip.judul
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      }

      if (filteredList.isEmpty) {
        return const Center(
          child: Text(
            'Belum ada arsip',
          ),
        );
      }

      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {

          final arsip = filteredList[index];

          return GestureDetector(
            onTap: () async {

              final refresh =
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditArsipPage(
                        arsip: arsip,
                      ),
                    ),
                  );

              if (refresh == true) {

                context
                    .read<ArsipProvider>()
                    .loadArsip();

              }
            },

            child: _arsipCard(
              title: arsip.judul,
              kategori: arsip.kategori,
              tanggal: arsip.tanggal,
            ),
          );
        },
      );
    },
  ),
)
        ],
      ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFFF48FB1),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }

          else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Arsip',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _arsipCard({
    required String title,
    required String kategori,
    required String tanggal,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFF7DCE6),

            child: const Icon(
              Icons.description_outlined,
              color: Color(0xFF9C466E),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF7DCE6),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Text(
                        kategori,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D4C57),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      tanggal,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}