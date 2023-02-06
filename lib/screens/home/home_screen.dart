import 'package:flutter/material.dart';
import 'package:route_app/screens/home/home_controller.dart' show HomeController;

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  Widget get _sizeBox => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            _sizeBox,
            ElevatedButton(
              onPressed: _controller.gotToUser,
              child: const Text('user'),
            ),
            _sizeBox,
            ElevatedButton(
              onPressed: _controller.gotToProfile,
              child: const Text('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
