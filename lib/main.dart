import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'splash_screen.dart'; 
import 'package:provider/provider.dart';
import 'providers/arsip_provider.dart';
import 'services/socket_services.dart';
import 'providers/notif_provider.dart';
import 'services/local_notification_service.dart';
import 'services/fcm_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // FIREBASE DULU
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // BARU FCM
  // await FCMService.init();

  // LOCAL NOTIF
  await LocalNotificationService.init();

  // SOCKET
  SocketService.instance.connect();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ArsipProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotifProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arsipku',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFF), // Ghost White
        fontFamily: 'Sans-Serif',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF475569), // Slate Blue
          primary: const Color(0xFF475569),
          surface: const Color(0xFFF8FAFF),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFF94A3B8)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF475569), width: 1.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),

      home: const SplashScreen(), 
    );
  }
}