import 'package:flutter/material.dart';
import 'package:route_app/screens/user/user_controller.dart' show UserController;

class UserScreen extends StatelessWidget {
  const UserScreen({
    required int id,
    required UserController controller,
    super.key,
    String? name,
  })  : _id = id,
        _name = name,
        _controller = controller;

  final int _id;
  final UserController _controller;
  final String? _name;

  Widget get _sizeBox => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('User $_id'),
          _sizeBox,
          ..._name != null && _name!.isNotEmpty ? [Text('name: $_name'), _sizeBox] : [],
          ElevatedButton(
            onPressed: _controller.gotToProfile,
            child: const Text('profile'),
          ),
        ],
      ),
    );
  }
}
