import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _alertsEnabled = true;
  final TextEditingController _phMinController = TextEditingController(text: "7.0");
  final TextEditingController _phMaxController = TextEditingController(text: "7.2");
  String _temperatureUnit = '°C';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const LinearGradient(
        colors: [Color(0xFFE0F7FA), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0.0, 0.0, 500.0, 500.0)) !=
              null
          ? Container(color: Colors.transparent).color
          : const Color(0xFFE0F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Configuración", style: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFB2EBF2),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.account_circle, size: 48),
                  SizedBox(height: 8),
                  Text("Samuel Camilo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Sanchez Lemaa", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Switch de alertas
            Row(
              children: [
                const Icon(Icons.notifications),
                const SizedBox(width: 10),
                const Text("Alertas"),
                const Spacer(),
                Switch(
                  value: _alertsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _alertsEnabled = value;
                    });
                  },
                ),
              ],
            ),

            // PH mínimo
            _textFieldWithIcon(
              icon: Icons.water_drop_outlined,
              label: "pH mínimo",
              controller: _phMinController,
            ),

            // PH máximo
            _textFieldWithIcon(
              icon: Icons.water_drop,
              label: "pH máximo",
              controller: _phMaxController,
            ),

            // Unidad de temperatura
            Row(
              children: [
                const Icon(Icons.thermostat_outlined),
                const SizedBox(width: 10),
                const Text("Unidades de Temperatura"),
                const Spacer(),
                DropdownButton<String>(
                  value: _temperatureUnit,
                  items: ['°C', '°F'].map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _temperatureUnit = value;
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Botón guardar
            ElevatedButton.icon(
              onPressed: _saveSettings,
              icon: const Icon(Icons.check),
              label: const Text("Guardar", style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 217, 235),
                foregroundColor: const Color(0xFF6750A4),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),

            const Spacer(),

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
    );
  }

  Widget _textFieldWithIcon({required IconData icon, required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    final minPh = _phMinController.text.trim();
    final maxPh = _phMaxController.text.trim();

    // Aquí podrías guardar en Firebase:
    // FirebaseDatabase.instance.ref('settings/user123').set({...});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Configuraciones guardadas")),
    );
  }
}
