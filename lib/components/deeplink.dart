import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

void configureDeepLink(BuildContext context) {
  final appLinks = AppLinks();
  bool hasHandled = false;

  appLinks.uriLinkStream.listen((uri) {
    if (uri == null || hasHandled) return;

    debugPrint("Received URI: $uri");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      hasHandled = true; // prevent re-navigation
      if (uri.host == 'reset-password') {
        Navigator.of(context).pushNamedAndRemoveUntil('/updatepasswordpage', (route) => false);
      } else if (uri.host == 'login-callback') {
        Navigator.of(context).pushNamedAndRemoveUntil('/tabs', (route) => false);
      }
    });
  }, onError: (err) {
    debugPrint("Deep Link Error: $err");
  });
}

