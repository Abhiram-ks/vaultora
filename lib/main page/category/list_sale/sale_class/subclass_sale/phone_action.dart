import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

Future<void> makePhoneCall(BuildContext context, String phoneNumber) async {
  final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);
  try {
      await launchUrl(phoneUrl);
  } catch (e) {
    log('Error launching phone call: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error launching phone call')),
    );
  }
}


