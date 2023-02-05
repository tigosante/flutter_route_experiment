import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart' show QRouterDelegate;
import 'package:route_app/router/app_router.dart' show AppRouter;

class Application extends StatelessWidget {
  const Application({
    super.key,
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: QRouterDelegate(_router.routes),
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
