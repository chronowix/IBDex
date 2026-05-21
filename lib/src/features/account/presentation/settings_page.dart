import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _notifEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          const _SettingsSectionTitle(title: 'Apparence'),
          SwitchListTile(
            title: const Text('Mode Sombre'),
            subtitle: const Text('Activer le thème nuit'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // TODO: à faire plus tard pour changer le thème global
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          const _SettingsSectionTitle(title: 'Notifications'),
          SwitchListTile(
            title: const Text('Alertes Actualités'),
            subtitle: const Text('Recevoir les nouveaux articles'),
            value: _notifEnabled,
            onChanged: (bool value) {
              setState(() {
                _notifEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          const Divider(),
          const _SettingsSectionTitle(title: 'Compte et Sécurité'),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Changer le mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Supprimer mon compte',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: afficher confirmation
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  final String title;
  const _SettingsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
    );
  }
}
