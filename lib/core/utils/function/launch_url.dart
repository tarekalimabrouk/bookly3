import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_snack_bar.dart';

Future<void> launchCustomUr(BuildContext context, String? url) async {
  if (url == null || url.trim().isEmpty) {
    customSnackBar(context, 'This link is not available.');
    return;
  }

  final Uri? uri = Uri.tryParse(url.trim());
  if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http')) {
    customSnackBar(context, 'The book link is invalid.');
    return;
  }

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      customSnackBar(context, 'Could not open the book link.');
    }
  } catch (_) {
    if (context.mounted) {
      customSnackBar(context, 'Could not open the book link.');
    }
  }
}
