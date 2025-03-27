import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<bool> goToURL({required String link}) async {
    Uri url = Uri.parse(link);
    try {
      return await launchUrl(url);
    } catch (e) {
      // ignore: avoid_print
      debugPrint("Error in launching url: $e");
      return false;
    }
  }
}
