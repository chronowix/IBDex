import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ibdex/src/shared/models/medical_center.dart';
import 'package:latlong2/latlong.dart';

final List<MedicalCenter> _rennesCenters = [
  MedicalCenter(
    name: 'CHU Pontchaillou',
    speciality: 'Centre hépato-digestif',
    address: '2 Rue Henri Le Guilloux, Rennes',
    position: const LatLng(48.1205, -1.6925),
  ),
  MedicalCenter(
    name: 'Clinique de la Sagesse',
    speciality: 'Médecine en gastro-entérologie/hépatologie',
    address: '4 Place Saint-Guénolé, Rennes',
    position: const LatLng(48.1132, -1.7056),
  ),
  MedicalCenter(
    name: 'CHP Saint-Grégoire',
    speciality: 'Gastro-entérologie',
    address: '6 Boulevard de la Boutière, Saint-Grégoire',
    position: const LatLng(48.1408, -1.6811),
  ),
  MedicalCenter(
    name: 'Hôpital Privé Sévigné',
    speciality: 'Gastro-entérologie et hépatologie',
    address: '3 Rue de la Linière, Cesson Sévigné',
    position: const LatLng(48.1158, -1.6163),
  ),
];

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carte des Spécialistes')),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(48.117267, -1.677792),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'fr.chrono.ibdex',
          ),
          MarkerLayer(
            markers: _rennesCenters.map((center) {
              return Marker(
                point: center.position,
                width: 80,
                height: 80,
                child: IconButton(
                  icon:
                      const Icon(Icons.location_on, color: Colors.red, size: 40),
                  onPressed: () {
                    _showCenterDetails(context, center);
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showCenterDetails(BuildContext context, MedicalCenter center) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(center.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(center.speciality, style: const TextStyle(color: Colors.blue)),
            const SizedBox(height: 10),
            Text(center.address),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: ouvrir l'itinéraire
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('Voir l\'itinéraire'),
            ),
          ],
        ),
      ),
    );
  }
}
