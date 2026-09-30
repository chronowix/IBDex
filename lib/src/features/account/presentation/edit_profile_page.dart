import 'package:flutter/material.dart';
import 'package:ibdex/src/features/account/data/user_profile_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _profileService = UserProfileService();
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _regionController = TextEditingController();
  final _otherMiciController = TextEditingController();

  static const _miciTypeOptions = ['Crohn', 'RCH', 'Autre'];
  String? _selectedMiciType;

  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _profileService.getCurrentProfile();
      if (mounted) {
        setState(() {
          _fullNameController.text = profile.fullName ?? '';
          _regionController.text = profile.region ?? '';

          final miciType = profile.miciType;
          if (miciType == null || miciType.isEmpty) {
            _selectedMiciType = null;
          } else if (miciType == 'Crohn' || miciType == 'RCH') {
            _selectedMiciType = miciType;
          } else {
            _selectedMiciType = 'Autre';
            _otherMiciController.text = miciType;
          }
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

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final miciTypeSave = _selectedMiciType == 'Autre'
        ? _otherMiciController.text.trim()
        : (_selectedMiciType ?? '');

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await _profileService.updateProfile(
          fullName: _fullNameController.text.trim(),
          region: _regionController.text.trim(),
          miciType: miciTypeSave,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil mis à jour!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erreur lors de la sauvegarde : $e';
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _regionController.dispose();
    _otherMiciController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                    ),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Nom complet'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _regionController,
                    decoration: const InputDecoration(labelText: 'Ville'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedMiciType,
                    decoration: const InputDecoration(labelText: 'Type de MICI'),
                    items: _miciTypeOptions
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedMiciType = value),
                    validator: (v) => v == null ? 'Sélectionne une option' : null,
                  ),
                  if (_selectedMiciType == 'Autre') ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _otherMiciController,
                      decoration: const InputDecoration(
                        labelText: 'Précisez',
                      ),
                      validator: (v) {
                        if (_selectedMiciType == 'Autre' &&
                            (v == null || v.trim().isEmpty)) {
                          return 'Précisez le type de MICI';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                      onPressed: _isSaving ? null : _saveProfile,
                      child: _isSaving
                          ? const SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text ('Enregistrer'),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}