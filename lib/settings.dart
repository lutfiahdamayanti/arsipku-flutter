import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:arsipku/notifications.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String username = 'User';
  bool darkMode = false;
  bool notification = true;

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
          'Pengaturan',
          style: TextStyle(
            color: Color(0xFF9C3F67),
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFF9C3F67),
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
                icon: const Icon(Icons.notifications_none_rounded,
                color: Color(0xFF6D4C57),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PROFIL AKUN',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 15),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFFF8D7E2),
                      child: Text(
                        username.isNotEmpty
                            ? username[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9C3F67),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            username,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 35),
            const Text(
              'PREFERENSI',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEEF4),
                      child: Icon(
                        Icons.dark_mode_outlined,
                        color: Color(0xFF9C3F67),
                      ),
                    ),
                    title: const Text(
                      'Mode Gelap',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Switch(
                      value: darkMode,
                      activeColor: const Color(0xFF9C3F67),
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    ),
                  ),
                  const Divider(),

                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEEF4),
                      child: Icon(
                        Icons.notifications_none,
                        color: Color(0xFF9C3F67),
                      ),
                    ),
                    title: const Text(
                      'Notifikasi',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Switch(
                      value: notification,
                      activeColor: const Color(0xFF9C3F67),
                      onChanged: (value) {
                        setState(() {
                          notification = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
            const Text(
              'INFORMASI',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),


            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEEF4),
                      child: Icon(
                        Icons.info_outline,
                        color: Color(0xFF9C3F67),
                      ),
                    ),
                    title: const Text(
                      'Tentang Aplikasi',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                    ),
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: const Text('Tentang Arsipku'),
                          content: const Text(
                            'Arsipku adalah aplikasi pengelolaan arsip digital yang membantu pengguna menyimpan, mencari, dan mengelola dokumen dengan mudah.'
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tutup'))
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEEF4),
                      child: Icon(
                        Icons.description_outlined,
                        color: Color(0xFF9C3F67),
                      ),
                    ),
                    title: const Text(
                      'Kebijakan Privasi',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                    ),
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                          title: const Text('Kebijakan Privasi'),
                          content: const SingleChildScrollView(
                            child: Text(
                              'Data pengguna digunakan hanya untuk kebutuhan aplikasi ArsipKu. Informasi akun tidak dibagikan kepada pihak ketiga tanpa izin pengguna.'
                              ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), 
                              child: const Text('Tutup'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton.icon(
                onPressed: logout,
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFF9C3F67),
                ),
                label: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C466E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Center(
              child: Text(
                'ArsipKu v1.0.0 • Dibuat dengan penuh cinta',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}