import 'dart:ui';

import 'package:arsipku/arsip.dart';
import 'package:arsipku/profil.dart';
import 'package:arsipku/tambah_arsip.dart';
import 'package:flutter/material.dart';
import 'package:arsipku/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/arsip_model.dart';
import 'services/arsip_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  String keyword = '';
  late Future<List<Arsip>> arsipFuture;

  @override
  void initState() {
    super.initState();
    getUser();
    arsipFuture = ArsipService().getArsip();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('userEmail') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        automaticallyImplyLeading: false,

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
            context, MaterialPageRoute(
              builder: (context) => const TambahArsipPage()
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // WELCOME CARD
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

                  Text(
                    'Halo, $username 👋',
                    style: const TextStyle(
                      color: Color(0xFF6D214F),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Selamat datang di ArsipKu',
                    style: TextStyle(
                      color: Color(0xFF6D214F),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Karena setiap catatan memiliki cerita yang layak untuk disimpan.',
                    style: TextStyle(
                      color: Color(0xFF6D214F),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

              // SEARCH BAR
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),

            // MENU TITLE
            const Text('Menu Utama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6D4C57),
              ),
            ),
            const SizedBox(height: 20),
            InkWell( 
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ArsipPage(),)
                );
              },
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: double.infinity,
                height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF1F5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.folder_copy_outlined,
                        size: 32,
                        color: Color(0xFF9C466E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Arsip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D4C57),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),

            // RECENT SECTION
            const Text(
              'Arsip Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6D4C57),
              ),
            ),

            const SizedBox(height: 18),

            FutureBuilder<List<Arsip>>(
              future: arsipFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } 
                if (snapshot.hasError) {
                  return const Text(
                    'Gagal memuat arsip',
                  );
                }

                final arsipList = snapshot.data ?? [];
                if (arsipList.isEmpty) {
                  return const Text(
                    'Belum ada arsip',
                  );
                }
                return Column(
                  children: arsipList
                  .take(3)
                  .map(
                    (arsip) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: _recentCard(
                        title: arsip.judul,
                        kategori: arsip.kategori,
                        date: arsip.tanggal,
                      ),
                    ),
                  )
                .toList(),
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF9C466E),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 0) {}

          else if (index == 1) {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => const ArsipPage(),
              )
            );
          }

          else if (index == 2) {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => const ProfilePage()),
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

  // MENU CARD
  Widget _menuCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
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

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            padding: const EdgeInsets.all(18),

            decoration: const BoxDecoration(
              color: Color(0xFFFFF1F5),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 32,
              color: const Color(0xFF9C466E),
            ),
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6D4C57),
            ),
          ),
        ],
      ),
    );
  }

  // RECENT CARD
  Widget _recentCard({
    required String title,
    required String kategori,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

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

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F5),
              borderRadius: BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.insert_drive_file_outlined,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF6D4C57),
                  ),
                ),
                const SizedBox(height: 5),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7DCE6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        kategori,
                        style: TextStyle(
                          color: Color(0xFF6D4C57),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}