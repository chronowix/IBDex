import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget{
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support et Urgence')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // section urgences
          const _SupportSectionTitle(title: 'Numéros d\'urgence'),
          _buildSupportTile(context, 'SAMU', '15', Icons.emergency, Colors.red),
          _buildSupportTile(context, 'SOS Médecins Rennes', '3624', Icons.medical_services, Colors.blue.shade900),

          const Divider(height: 40),

          // section CHU
          const _SupportSectionTitle(title: 'CHU Rennes - Pontchaillou'),
          _buildSupportTile(context, 'Service gastro-entérologie', '02 99 28 43 21', Icons.local_hospital, Colors.red),
          const _SupportSectionTitle(title: 'CHU Rennes - Hôpital Sud'),
          _buildSupportTile(context, 'Service gastro-pédiatrie', '02 99 26 71 14', Icons.local_hospital, Colors.red),

          // section assos
          const _SupportSectionTitle(title: 'Associations'),
          _buildSupportTile(context, 'AFA Crohn RCH', 'afa.asso.fr', Icons.groups, Colors.green),
        ],
      ),
    );
  }

  // construct contacts
  Widget _buildSupportTile(BuildContext context, String name, String contact, IconData icon, Color color){
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(contact),
        trailing: const Icon(Icons.phone_forwarded),
        onTap: (){
          // TODO: à faire plus tard -> utiliser url_lancer pour rediriger vers l'appli d'appel
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appel vers $name...')),
          );
        },
      ),
    );
  }
}

class _SupportSectionTitle extends StatelessWidget{
  final String title;
  const _SupportSectionTitle({required this.title});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight:  FontWeight.bold, color: Colors.blueGrey)),
    );
  }
}