import 'package:flutter/material.dart' show runApp;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:route_app/application.dart' deferred as app show Application;
import 'package:route_app/main/dependency_injection/dependency_injection.dart' deferred as dependecy_injection
    show DependencyInjectionImpl, InstanceType;
import 'package:route_app/router/app_router.dart' show AppRouter, AppRouterConcrete;
import 'package:route_app/router/import.dart' deferred as route_config show routesConfig;

final _getItInstance = GetIt.instance;

Future<void> main() async {
  await Future.wait([
    app.loadLibrary(),
    route_config.loadLibrary(),
    dependecy_injection.loadLibrary(),
  ]);

  final dependecy = dependecy_injection.DependencyInjectionImpl(provider: _getItInstance)
    ..setInstance<AppRouter>(AppRouterConcrete.new, instanceType: dependecy_injection.InstanceType.singleton);

  final router = await route_config.routesConfig(dependecy);
  runApp(app.Application(router: router));
}
