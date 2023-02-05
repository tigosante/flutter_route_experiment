import 'package:flutter/material.dart';
import 'package:route_app/screens/login/login_controller.dart' show LoginController;

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required LoginController controller,
  }) : _controller = controller;

  final LoginController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("store screen"),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.login,
            child: Text("login"),
          ),
        ],
      ),
    );
  }
}
