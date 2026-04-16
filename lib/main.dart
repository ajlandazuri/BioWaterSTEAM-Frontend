import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'water_quality_screen.dart';
import 'add_location_screen.dart'; // si la usas
import 'historical_readings_screen.dart'; // pantalla de historial
import 'settings_screen.dart'; // si la usas
import 'graph_screen.dart'; // si la usas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STEAM App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black),
        ),
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      // Pantalla inicial: login
      home: const LoginScreen(),

      // Rutas
      routes: {
        '/login': (context) => const LoginScreen(),
        '/waterQuality': (context) => const WaterQualityScreen(),
        '/addLocation': (context) => const AddLocationScreen(), // opcional
        '/historicalReadings': (context) => const HistoryScreen(), // pantalla de historial
        '/settings': (context) => const SettingsScreen(), // si la usas
        '/graph': (context) => const GraphScreen(), // si la usas
      },
      

    );
    
    
  }
}