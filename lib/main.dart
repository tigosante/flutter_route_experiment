import 'package:flutter/material.dart' show runApp;
import 'package:route_app/application.dart' deferred as app show Application;
import 'package:route_app/router/app_router.dart' deferred as app_router show AppRouterConcrete;
import 'package:route_app/router/import.dart' deferred as route_config show routesConfig;

Future<void> main() async {
  await Future.wait([
    app.loadLibrary(),
    app_router.loadLibrary(),
    route_config.loadLibrary(),
  ]);

  final router = await route_config.routesConfig(app_router.AppRouterConcrete());
  runApp(app.Application(router: router));
}
