import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keycloak_ex2/login_page_two.dart';
import 'package:openid_client/openid_client_io.dart';

import 'openid_io.dart';
import 'sign_up_page.dart';
import 'user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Credential? credential;
  // final String _clientId = 'vipilink-app';
  final String _clientId = 'sample-flutter';
  static const String _issuer =
      // 'https://108.61.103.32:8443/auth/realms/vipilink';
      'http://localhost:8080/auth/realms/sample';
  // 'https://108.61.103.32:8443/realms/vipilink/account';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
    'offline_access',
  ];
  UserInfo? userInfo;
  String logoutUrl = '';
  late final Client client;

  void getClient() async {
    var uri = Uri.parse(_issuer);
    if (!kIsWeb && Platform.isAndroid) uri = uri.replace(host: '10.0.2.2');

    var issuer = await Issuer.discover(uri);
    client = Client(issuer, _clientId);
    credential = await getRedirectResult(client, scopes: _scopes);
  }

  @override
  void initState() {
    getClient();
    if (credential != null) {
      credential!.getUserInfo().then((userInfo) {
        setState(() {
          this.userInfo = userInfo;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userInfo == null
          ? LoginPageTwo(login: () async {
              // credential = await authenticate(client, scopes: _scopes);
              // var userInfo = await credential!.getUserInfo();
              // setState(() {
              //   this.userInfo = userInfo;
              //   logoutUrl = credential!.generateLogoutUrl().toString();
              // });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ));
            })
          : UserPage(
              userInfo: userInfo,
              logout: () async {
                await logout(logoutUrl);
                setState(() {
                  userInfo = null;
                });
              },
            ),
    );
  }
}
