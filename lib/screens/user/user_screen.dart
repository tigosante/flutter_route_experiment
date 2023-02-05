import 'package:flutter/material.dart';
import 'package:route_app/screens/user/user_controller.dart' show UserController;

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
    required UserController controller,
  }) : _controller = controller;

  final UserController _controller;

  Widget get _sizeBox => SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("User screen"),
          _sizeBox,
          ElevatedButton(
            onPressed: _controller.back,
            child: Text("back"),
          ),
          _sizeBox,
          ElevatedButton(
            onPressed: _controller.gotToProfile,
            child: Text("profile"),
          ),
        ],
      ),
    );
  }
}
