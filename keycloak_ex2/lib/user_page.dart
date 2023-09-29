// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';

class UserPage extends StatelessWidget {
  final UserInfo? userInfo;
  final Future Function() logout;
  const UserPage({
    Key? key,
    required this.userInfo,
    required this.logout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello ${userInfo!.name}'),
            Text(userInfo!.email ?? ''),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
              // onPressed: () async {
              // await logout(logoutUrl);
              // setState(() {
              //   userInfo = null;
              // });
              // },
            )
          ],
        ),
      ),
    );
  }
}
