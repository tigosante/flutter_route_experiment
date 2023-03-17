import 'package:flutter/material.dart';
import 'package:route_app/screens/login/login_controller.dart' show LoginController;

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required LoginController controller,
    super.key,
  }) : _controller = controller;

  final LoginController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('store screen'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.login,
            child: const Text('login'),
          ),
        ],
      ),
    );
  }
}
