import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    String? userTpe,
  }) : _userTpe = userTpe;

  final String? _userTpe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _userTpe != null ? Text("type: $_userTpe") : Text("Profile screen"),
      ),
    );
  }
}
