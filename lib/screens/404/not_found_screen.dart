import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:route_app/screens/404/not_found_controller.dart' show NotFoundController;

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    required NotFoundController controller,
    super.key,
    dynamic message,
  })  : _message = message,
        _controller = controller;

  final dynamic _message;
  final NotFoundController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(!kReleaseMode ? '404\n$_message' : '404'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.gotToHome,
            child: const Text('back to home'),
          ),
        ],
      ),
    );
  }
}
