import 'package:flutter/material.dart';
import 'package:route_app/screens/home/home_controller.dart' show HomeController;

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  Widget get _sizeBox => SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Home screen"),
            _sizeBox,
            ElevatedButton(
              onPressed: _controller.gotToUser,
              child: Text("user"),
            ),
            _sizeBox,
            ElevatedButton(
              onPressed: _controller.gotToProfile,
              child: Text("profile"),
            ),
          ],
        ),
      ),
    );
  }
}
