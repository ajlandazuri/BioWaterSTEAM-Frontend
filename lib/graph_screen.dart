import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  List<FlSpot> phSpots = [];
  List<FlSpot> tempSpots = [];
  List<FlSpot> turbiditySpots = [];
  List<String> xLabels = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final snapshot = await _dbRef.child('waterQuality/historicalReadings').get();
    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      final sortedKeys = data.keys.toList()
        ..sort((a, b) => data[a]['timestamp'].compareTo(data[b]['timestamp']));

      List<FlSpot> phTemp = [];
      List<FlSpot> tempTemp = [];
      List<FlSpot> turbTemp = [];
      List<String> labels = [];

      int index = 0;
      for (var key in sortedKeys) {
        final item = data[key];
        if (item['timestamp'] != null &&
            item['ph'] != null &&
            item['temperature'] != null &&
            item['turbidity'] != null) {
          phTemp.add(FlSpot(index.toDouble(), (item['ph'] as num).toDouble()));
          tempTemp.add(FlSpot(index.toDouble(), (item['temperature'] as num).toDouble()));
          turbTemp.add(FlSpot(index.toDouble(), (item['turbidity'] as num).toDouble()));

          final date = DateTime.fromMillisecondsSinceEpoch(item['timestamp']);
          labels.add(DateFormat('d/M').format(date)); // Ej: 1/7
          index++;
        }
      }

      setState(() {
        phSpots = phTemp;
        tempSpots = tempTemp;
        turbiditySpots = turbTemp;
        xLabels = labels;
        isLoading = false;
      });
    }
  }

  Widget buildChart() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: phSpots,
            isCurved: true,
            barWidth: 2.5,
            color: Colors.purple,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: tempSpots,
            isCurved: true,
            barWidth: 2.5,
            color: Colors.orange,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: turbiditySpots,
            isCurved: true,
            barWidth: 2.5,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                int idx = value.toInt();
                if (idx >= 0 && idx < xLabels.length) {
                  return Text(xLabels[idx], style: const TextStyle(fontSize: 10));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gráfico de Agua', style: TextStyle(fontSize: 15))),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                 
                  const SizedBox(height: 16),
                  Expanded(child: buildChart()),
                  const SizedBox(height: 16),
                  const Text("pH ", style: TextStyle(color: Colors.purple)),
                  const Text("Temperatura ", style: TextStyle(color: Colors.orange)),
                  const Text("Turbidez", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
    );
  }
}
