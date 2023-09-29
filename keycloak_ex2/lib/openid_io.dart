import 'dart:io';

import 'package:openid_client/openid_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:openid_client/openid_client_io.dart' as io;

// import 'main.dart';

Future<Credential> authenticate(Client client,
    {List<String> scopes = const []}) async {
  // create a function to open a browser with an url
  urlLauncher(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri) || Platform.isAndroid) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // create an authenticator
  var authenticator = io.Authenticator(
    client,
    scopes: scopes,
    port: 4000,
    urlLancher: urlLauncher,
  );

  // starts the authentication
  var c = await authenticator.authorize();

  // close the webview when finished
  if (Platform.isAndroid || Platform.isIOS) {
    closeInAppWebView();
  }
  print('Authentification completed');
  print('flow type - ${authenticator.flow.type}');
  return c;
}

Future<Credential?> getRedirectResult(Client client,
    {List<String> scopes = const []}) async {
  var f = Flow.authorizationCodeWithPKCE(client);
  print('flow type - ${f.state}');
  return null;
}

Future<void> logout(String logoutUrl) async {
  var uri = Uri.parse(logoutUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $logoutUrl';
  }
  await Future.delayed(const Duration(seconds: 3));
  closeInAppWebView();
}
