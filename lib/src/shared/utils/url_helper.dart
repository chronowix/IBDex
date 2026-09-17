import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launchURL(String urlString) async{
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)){
      throw Exception('Impossible d\'ouvrir l\'URL : $urlString');
    }
  }
}