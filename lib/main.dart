import 'package:flutter/material.dart';
import 'screen/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // <--- เอาคำว่า const ออกจากตรงนี้
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // และตรงนี้ไม่ต้องมี const
    );
  }
}