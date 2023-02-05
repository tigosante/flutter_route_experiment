import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:route_app/screens/404/not_found_controller.dart' show NotFoundController;

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    dynamic message,
    required NotFoundController controller,
  })  : _message = message,
        _controller = controller;

  final dynamic _message;
  final NotFoundController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(!kReleaseMode ? "404\n${_message.toString()}" : "404"),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.gotToHome,
            child: Text("back to home"),
          ),
        ],
      ),
    );
  }
}
