import 'package:flutter/material.dart';
import 'package:route_app/router/import.dart' show AppRouter;

class Application extends StatelessWidget {
  const Application({
    required AppRouter router,
    super.key,
  }) : _router = router;

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
