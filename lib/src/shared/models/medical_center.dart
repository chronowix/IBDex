import 'package:latlong2/latlong.dart';

class MedicalCenter {
  final String name;
  final String speciality;
  final String address;
  final LatLng position;

  MedicalCenter({
    required this.name,
    required this.speciality,
    required this.address,
    required this.position,
  });
}