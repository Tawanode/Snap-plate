// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/screens/camera_screen.dart';
import 'src/screens/log_screen.dart';
import 'src/screens/profile_screen.dart';
import 'src/services/firebase_service.dart';
import 'src/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load environment (make sure you create a .env file locally - DO NOT COMMIT)
  await dotenv.load(fileName: ".env");

  // init Supabase - we use placeholders; replace with real values in local .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  // init Firebase (stub - implement in firebase_service)
  await FirebaseService.init();

  runApp(const SnapPlateApp());
}

class SnapPlateApp extends StatelessWidget {
  const SnapPlateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapPlate',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScaffold(),
        '/camera': (_) => const CameraScreen(),
        '/log': (_) => const LogScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SnapPlate')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Open Camera'),
              onPressed: () => Navigator.pushNamed(context, '/camera'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Daily Log'),
              onPressed: () => Navigator.pushNamed(context, '/log'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Profile'),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
      ),
    );
  }
}
