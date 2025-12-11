import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      // You can add analytics/fcm init here later
      print('Firebase initialized');
    } catch (e) {
      print('Firebase init error: $e');
    }
  }
}
