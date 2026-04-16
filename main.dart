import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RRDCHApp());
}

class RRDCHApp extends StatelessWidget {
  const RRDCHApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RRDCH – Rajarajeshwari Dental College & Hospital',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
