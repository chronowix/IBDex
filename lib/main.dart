import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app/app.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
        ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
      url: 'https://yoxdisdhnufonwdglgqt.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlveGRpc2RobnVmb253ZGdsZ3F0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkzOTk5MTYsImV4cCI6MjA5NDk3NTkxNn0.JwSvGlwM2kGUt15kMH4MmQk_LJLpw6dlXhuTAkYcPKg'
  );
  runApp(const IbdexApp());
}
