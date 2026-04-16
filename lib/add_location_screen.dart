import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

 Future<void> _saveLocation() async {
  final location = _locationController.text.trim();
  if (location.isEmpty) return;

  try {
    final prototipoRef = _dbRef.child('waterQuality/locations');
    final historicalRef = prototipoRef.child('historicalLocations');

    // Leer las ubicaciones actuales
    final snapshot = await historicalRef.get();

    bool alreadyExists = false;

    if (snapshot.exists) {
      final data = snapshot.value as Map;
      alreadyExists = data.values.any((value) {
        if (value is Map && value['name'] != null) {
          return value['name'].toString().toLowerCase() == location.toLowerCase();
        }
        return false;
      });
    }

    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La ubicación ya existe.')),
      );
      return;
    }

    // Actualiza la ubicación actual
    await prototipoRef.update({
      'currentLocation': location,
    });

    // Agrega la nueva ubicación al historial
    await historicalRef.push().set({
      'name': location,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ubicación guardada exitosamente')),
    );

    _locationController.clear();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al guardar: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asignar ubicación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la ubicación',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveLocation,
              child: const Text('Guardar ubicación'),
            ),
          ],
        ),
      ),
    );
  }
}
