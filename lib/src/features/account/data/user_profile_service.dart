import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String id;
  final String? fullName;
  final String email;
  final String? region;
  final String? miciType;

  UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.region,
    required this.miciType,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      region: json['region'] as String?,
      miciType: json['mici_type'] as String?,
    );
  }
}

class UserProfileService {
  final _client = Supabase.instance.client;

  Future<UserProfile> getCurrentProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Utilisateur non connecté');
    }

    final data = await _client.from('users').select().eq('id', userId).single();

    return UserProfile.fromJson(data);
  }

  Future<void> updateProfile({
    required String fullName,
    required String region,
    required String miciType,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Utilisateur non connecté');
    }

    await _client.from('users').update({
      'full_name': fullName,
      'region': region,
      'mici_type': miciType,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }
}