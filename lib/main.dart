import 'package:flutter/material.dart';
import 'pages/katalog_page.dart';

void main() {
  runApp(const AndMusicStoreApp());
}

class AndMusicStoreApp extends StatelessWidget {
  const AndMusicStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'And Music Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121218),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF59E0B),
          secondary: Color(0xFF38BDF8),
          surface: Color(0xFF1E1E2A),
        ),
        useMaterial3: true,
      ),
      home: const KatalogPage(),
    );
  }
}