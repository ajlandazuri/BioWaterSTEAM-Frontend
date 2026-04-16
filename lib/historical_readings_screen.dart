import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _database = FirebaseDatabase.instance.ref();
  Map<String, List<Map<String, dynamic>>> groupedData = {};

 @override
void initState() {
  super.initState();
  initializeDateFormatting('es_ES', null).then((_) {
    _loadHistoricalData();
  });
}

  Future<void> _loadHistoricalData() async {
    final snapshot = await _database.child('waterQuality/historicalReadings').get();

    if (snapshot.exists) {
      final rawData = Map<String, dynamic>.from(snapshot.value as Map);
      Map<String, List<Map<String, dynamic>>> tempGrouped = {};

      for (var entry in rawData.entries) {
        final reading = Map<String, dynamic>.from(entry.value);

        final timestamp = DateTime.fromMillisecondsSinceEpoch(reading['timestamp']);
        final dateKey = DateFormat('EEEE, d/M/yyyy', 'es_ES').format(timestamp);

        if (!tempGrouped.containsKey(dateKey)) {
          tempGrouped[dateKey] = [];
        }

        tempGrouped[dateKey]!.add({
          'time': DateFormat('HH:mm:ss').format(timestamp),
          'ph': reading['ph'],
          'temperature': reading['temperature'],
          'turbidity': reading['turbidity'],
        });
      }

      setState(() {
        groupedData = tempGrouped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial", style: TextStyle(fontSize: 15)),
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
      body: groupedData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: groupedData.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...entry.value.map((reading) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF72FFAF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reading['time'], style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 4),
                              Text("pH: ${reading['ph']}   T: ${reading['temperature']}°   Turbidez: ${reading['turbidity']}"),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
