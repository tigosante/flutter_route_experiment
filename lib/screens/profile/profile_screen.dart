import 'package:flutter/material.dart';
import 'package:route_app/screens/profile/profile_controller.dart' show ProfileController;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required ProfileController controller,
  }) : _controller = controller;

  final ProfileController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Profile screen"),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.back,
            child: Text("back"),
          ),
        ],
      ),
    );
  }
}
