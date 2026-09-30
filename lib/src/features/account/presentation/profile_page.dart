import 'package:flutter/material.dart';
import 'package:ibdex/src/features/account/data/user_profile_service.dart';
import 'package:ibdex/src/features/account/presentation/edit_profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileService = UserProfileService();

  UserProfile? _profile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profile = await _profileService.getCurrentProfile();
      if (mounted) {
        setState(() {
          _profile = profile;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erreur de chargement : $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final profile = _profile!;
    final fullName = profile.fullName ?? 'Utilisateur IBDex';
    final email = profile.email;
    final city = profile.region ?? 'Non renseignée';
    final miciType = profile.miciType ?? 'Non renseigné';

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
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
          Text(fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(city, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),

          const Divider(),
          _buildProfileItem(Icons.email, 'Email', email),
          _buildProfileItem(Icons.location_on, 'Ville', city),
          _buildProfileItem(Icons.health_and_safety, 'Type de MICI', miciType),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );
                    _loadProfile();
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Modifier mon profil'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Se déconnecter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
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