// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Error"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}
