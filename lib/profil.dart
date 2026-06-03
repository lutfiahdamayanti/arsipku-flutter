import 'package:arsipku/arsip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'settings.dart';
import 'package:arsipku/notifications.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String username = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('userEmail') ?? 'User';
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F3F6),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Profil',
          style: TextStyle(
            color: Color(0xFF9C466E),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            // PROFILE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                  color: const Color(0xFFF4AFC8),
                borderRadius: BorderRadius.circular(30),
              ),

              child: Column(
                children: [

                  Container(
                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: const Icon(
                      Icons.person_rounded,
                      size: 38,
                      color: Color(0xFF6D214F),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    username,
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Color(0xFF6D214F),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Simpan setiap cerita pentingmu.',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Color(0xFF6D214F),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // MENU CARD
            _menuTile(
              icon: Icons.folder_copy_outlined,
              title: 'Total Arsip',
              subtitle: 'Arsip tersimpan',
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const ArsipPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            _menuTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notifikasi',
              subtitle: 'Semua pemberitahuan aplikasi',
              onTap: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                );
              },
            ),

            const SizedBox(height: 18),

            _menuTile(
              icon: Icons.settings_outlined,
              title: 'Pengaturan',
              subtitle: 'Atur preferensi aplikasi',
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: logout,

                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),

                label: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C466E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),      
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),      
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
                color: const Color(0xFFF7DCE6),
                borderRadius: BorderRadius.circular(15),
              ),      
              child: Icon(
                icon,
                color: const Color(0xFF9C466E),
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
      
                  Text(
                    subtitle,      
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
      
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}