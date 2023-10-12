import 'package:flutter/material.dart';
import 'package:flutter_memer/themes.dart';
import 'package:flutter_memer/views/home_view.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: "Meme app",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MyThemes.darkColorScheme,
        fontFamily: GoogleFonts.outfit().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
