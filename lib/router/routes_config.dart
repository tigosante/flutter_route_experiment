import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:go_router/go_router.dart' deferred as route_provider show GoRouter;
import 'package:route_app/main/dependency_injection/dependency_injection.dart' show DependencyInjection;
import 'package:route_app/router/import.dart' show AppRouter;
import 'package:route_app/router/route_enum.dart' deferred as enums show RouteEnum;
import 'package:route_app/router/routes/home_route.dart' deferred as home_route show HomeRoute;
import 'package:route_app/router/routes/login_route.dart' deferred as login_route show LoginRoute;
import 'package:route_app/screens/404/import.dart' deferred as not_found show NotFoundController, NotFoundScreen;

Future<AppRouter> routesConfig(DependencyInjection dependency) async {
  await Future.wait([
    enums.loadLibrary(),
    not_found.loadLibrary(),
    route_provider.loadLibrary(),
    login_route.loadLibrary(),
    home_route.loadLibrary(),
  ]);

  final provider = route_provider.GoRouter(
    debugLogDiagnostics: !kReleaseMode,
    initialLocation: enums.RouteEnum.home.path,
    routes: [
      home_route.HomeRoute(dependency: dependency).route(),
      login_route.LoginRoute(dependency: dependency).route(),
    ],
    errorBuilder: (_, state) => not_found.NotFoundScreen(
      message: state.error,
      controller: not_found.NotFoundController(router: dependency.get()),
    ),
  );

  return dependency.get<AppRouter>()..provider(provider);
}
