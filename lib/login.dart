import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:arsipku/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoginMode = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _orgNameController = TextEditingController();

  Future<void> _processAuth() async {
    final prefs = await SharedPreferences.getInstance();

    if (_isLoginMode) {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', _emailController.text);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Selamat datang kembali di ArsipKu'),
            ),
          );

          Navigator.pushReplacement(
            context, MaterialPageRoute(
              builder: (context)  => const HomePage()),
          );
        }
      }
    } else {
      if (_orgNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty) {
        setState(() {
          _isLoginMode = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Organisasi berhasil didaftarkan! Silakan login.',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F3F6),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Container(
            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // LOGO
                const Center(
                  child: Image(
                    image: AssetImage('assets/logo/icons.png'),
                    width: 70,
                  ),
                ),

                const SizedBox(height: 35),

                // TITLE
                Center(
                  child: Text(
                    _isLoginMode ? 'Login' : 'Register',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D4C57),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // SUBTITLE
                Center(
                  child: Text(
                    _isLoginMode
                        ? 'Gunakan akun Anda.'
                        : 'Buat ruang arsip Anda.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFB08994),
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // INPUT ORGANISASI
                if (!_isLoginMode) ...[
                  _inputField(
                    _orgNameController,
                    'Nama Organisasi',
                    icon: Icons.groups_rounded,
                  ),

                  const SizedBox(height: 20),
                ],

                // EMAIL
                _inputField(
                  _emailController,
                  'Email',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                // PASSWORD
                _inputField(
                  _passwordController,
                  'Password',
                  hideText: true,
                  icon: Icons.lock_outline_rounded,
                ),

                const SizedBox(height: 40),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: _processAuth,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF48FB1),
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: Text(
                      _isLoginMode ? 'LOGIN' : 'REGISTER',

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 25),
                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final authService = AuthService();
                      final user = await authService.signInWithGoogle();
                      if (user != null && mounted) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      await prefs.setString(
                        'userEmail',
                        user.email ?? 'User',
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    }
                  },

                    icon: const Icon(
                      Icons.login,
                      color: Color(0xFFF48FB1),
                    ),

                    label: const Text(
                      'Login dengan Google',
                      style: TextStyle(
                        color: Color(0xFF6D4C57),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFF8BBD0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 25),

                // SWITCH LOGIN / REGISTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      _isLoginMode
                          ? 'Belum punya akun? '
                          : 'Sudah punya akun? ',

                      style: const TextStyle(
                        color: Color(0xFFB08994),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoginMode = !_isLoginMode;
                        });
                      },

                      child: Text(
                        _isLoginMode ? 'Buat Akun' : 'Login',

                        style: const TextStyle(
                          color: Color(0xFFF48FB1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // INPUT FIELD
  Widget _inputField(
    TextEditingController controller,
    String label, {
    bool hideText = false,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: hideText,

      style: const TextStyle(
        color: Color(0xFF6D4C57),
      ),

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(
          icon,
          color: const Color(0xFFD48A9B),
        ),

        labelStyle: const TextStyle(
          color: Color(0xFFD48A9B),
          fontSize: 14,
        ),

        filled: true,
        fillColor: const Color(0xFFFFF6F8),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Color(0xFFF8BBD0),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),

          borderSide: const BorderSide(
            color: Color(0xFFF48FB1),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}