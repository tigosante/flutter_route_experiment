import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  Widget get _sizeBox => SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("store screen"),
          _sizeBox,
          ElevatedButton(
            onPressed: () {},
            child: Text("back"),
          ),
          _sizeBox,
          ElevatedButton(
            onPressed: () {},
            child: Text("profile"),
          ),
        ],
      ),
    );
  }
}
