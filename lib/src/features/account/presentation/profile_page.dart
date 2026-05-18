import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Mon Profil')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          // 1. PHOTO DE PROFIL
          Center(
            child: GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.blue.shade100,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('https://picsum.photos/200'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
            const Text(
              'User IBDex',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Rennes, Bretagne', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            const Divider(),
            _buildProfileItem(Icons.email, 'Email', 'user@ibdex.com'),
            _buildProfileItem(Icons.phone, 'Téléphone', '06 01 02 03 04'),
            _buildProfileItem(Icons.location_on, 'Ville', 'Rennes'),

            const SizedBox(height: 20),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: (){
                  //TODO: form modification
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Modifier mon profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value){
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implémenter image_picker
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Appareil photo'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implémenter image_picker
                },
              ),
            ],
          ),
        );
      },
    );
  }
}