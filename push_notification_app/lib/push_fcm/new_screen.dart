// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String info;
  const NewPage({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Messaging'),
      ),
      body: Center(
        child: Text(info),
      ),
    );
  }
}
