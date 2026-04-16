import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';


class WaterQualityScreen extends StatefulWidget {
  const WaterQualityScreen({super.key});

  @override
  State<WaterQualityScreen> createState() => _WaterQualityScreenState();
}

class _WaterQualityScreenState extends State<WaterQualityScreen> {
  final _database = FirebaseDatabase.instance.ref();
  Map<String, dynamic>? currentData;

  @override
  void initState() {
    super.initState();
    _database.child('waterQuality/currentReading').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          currentData = Map<String, dynamic>.from(data as Map);
        });
      }
    });
  }

  @override
 @override
Widget build(BuildContext context) {
  if (currentData != null) {
    final calidad = evaluarCalidadDelAgua(currentData!);
    final estilo = obtenerEstiloCalidad(calidad);
    int timestampMillis = currentData!['timestamp'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    String formattedDate = DateFormat('dd/MM/yyyy – HH:mm:ss').format(date);


    return Scaffold(
      backgroundColor: const Color(0xFFE3F7FD),
      appBar: AppBar(
       title: const Text("Calidad del Agua", style: TextStyle(fontSize: 15)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 12),
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 128, 230, 253), Color(0xFFE3F7FD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Última actualización",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                  Padding(padding: const EdgeInsets.only(top: 15)),
              const SizedBox(height: 4),
              Text("$formattedDate",
                  style: TextStyle(fontSize: 14, color: Colors.black54)),

              const SizedBox(height: 12),
              Padding(padding: EdgeInsets.only(top: 12)),
              _dataRow(Icons.water_drop, "Turbidez", "${currentData!['turbidity']} mg/L"),

              const SizedBox(height: 12),
              Padding(padding: EdgeInsets.only(top: 12)),
              _dataRow(Icons.thermostat, "Temperatura", "${currentData!['temperature']} °C"),

              const SizedBox(height: 12),
              Padding(padding: EdgeInsets.only(top: 12)),
              _dataRow(Icons.science, "pH", "${currentData!['ph']}"),

              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: estilo['color'],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(estilo['icon'], color: Colors.black),
                    const SizedBox(width: 12),
                    const Text("Calidad de Agua", style: TextStyle(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text(estilo['label'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/historicalReadings');
                        },
                        icon: const Icon(Icons.list, color: Colors.purple),
                        label: const Text("Historial", style: TextStyle(color: Colors.purple)),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFEAE0FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/graph');
                        },
                        icon: const Icon(Icons.table_chart, color: Color.fromARGB(255, 56, 184, 213)),
                        label: const Text("Gráfico", style: TextStyle(color: Color.fromARGB(255, 39, 160, 176))),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 224, 253, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Column(
                    children: [
                      Text(
                        "BioWater",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [Color.fromARGB(255, 92, 208, 240), Color.fromARGB(255, 110, 0, 245)],
                            ).createShader(const Rect.fromLTWH(180, 200, 140, 0)),
                        ),
                      ),
                      Text(
                        "Steam",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF72FFAF),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  } else {
    return const Scaffold(
      backgroundColor: Color(0xFFE3F7FD),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


  Widget _dataRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 68, 68, 68))),
      ],
    );
  }
  String evaluarCalidadDelAgua(Map<String, dynamic> data) {
  final double ph = data['ph'] ?? 7.0;
  final double temperatura = data['temperature'] ?? 25.0;
  final double turbidez = data['turbidity'] ?? 5.0;
  final double oxigeno = data['oxygen'] ?? 6.0;

  bool buena = (ph >= 6.5 && ph <= 8.5) &&
               (temperatura >= 10 && temperatura <= 30) &&
               (turbidez <= 5) &&
               (oxigeno >= 6);

  bool mala = (ph < 5.5 || ph > 9.0) ||
              (temperatura < 5 || temperatura > 35) ||
              (turbidez > 10) ||
              (oxigeno < 4);

  if (buena) return "Buena";
  if (mala) return "Mala";
  return "Media";
}
Map<String, dynamic> obtenerEstiloCalidad(String calidad) {
  switch (calidad) {
    case "Buena":
      return {
        'icon': Icons.sentiment_satisfied_alt,
        'color': Colors.greenAccent.shade100,
        'label': "Buena"
      };
    case "Media":
      return {
        'icon': Icons.sentiment_neutral,
        'color': Colors.amberAccent.shade100,
        'label': "Media"
      };
    case "Mala":
      return {
        'icon': Icons.sentiment_dissatisfied,
        'color': Colors.redAccent.shade100,
        'label': "Mala"
      };
    default:
      return {
        'icon': Icons.help_outline,
        'color': Colors.grey.shade300,
        'label': "Desconocida"
      };
  }
}

}