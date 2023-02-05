import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:go_router/go_router.dart' deferred as route_provider show GoRoute, GoRouter;
import 'package:route_app/router/guards/import.dart' deferred as guards show UserGuard;
import 'package:route_app/router/import.dart' show AppRouter, deferredLoad;
import 'package:route_app/router/route_enum.dart' deferred as enums show RouteEnum;
import 'package:route_app/screens/404/import.dart' deferred as not_found show NotFoundScreen, NotFoundController;
import 'package:route_app/screens/home/import.dart' deferred as home;
import 'package:route_app/screens/login/import.dart' deferred as login;
import 'package:route_app/screens/profile/import.dart' deferred as profile;
import 'package:route_app/screens/user/import.dart' deferred as user;

Future<AppRouter> routesConfig(AppRouter router) async {
  await Future.wait([
    enums.loadLibrary(),
    guards.loadLibrary(),
    not_found.loadLibrary(),
    route_provider.loadLibrary(),
  ]);

  final provider = route_provider.GoRouter(
    debugLogDiagnostics: !kReleaseMode,
    initialLocation: enums.RouteEnum.home.path,
    errorBuilder: (_, state) => not_found.NotFoundScreen(
      message: state.error,
      controller: not_found.NotFoundController(router: router),
    ),
    routes: [
      route_provider.GoRoute(
        path: "/" + enums.RouteEnum.login.path,
        redirect: (_, __) => deferredLoad(login.loadLibrary),
        builder: (_, __) => login.LoginScreen(controller: login.LoginController(router: router)),
      ),
      route_provider.GoRoute(
        path: enums.RouteEnum.home.path,
        redirect: (_, __) => deferredLoad(home.loadLibrary),
        builder: (_, state) => home.HomeScreen(controller: home.HomeController(router: router)),
        routes: [
          route_provider.GoRoute(
            path: enums.RouteEnum.user.path + "/:id",
            redirect: guards.UserGuard(deferred: user.loadLibrary).redirect,
            builder: (_, state) {
              return user.UserScreen(
                name: state.queryParams["name"],
                id: int.tryParse(state.params["id"]!)!,
                controller: user.UserController(router: router),
              );
            },
            routes: [
              route_provider.GoRoute(
                path: enums.RouteEnum.profile.path,
                redirect: (_, __) => deferredLoad(profile.loadLibrary),
                builder: (_, state) => profile.ProfileScreen(userTpe: state.queryParams["user_type"]),
              ),
            ],
          ),
          route_provider.GoRoute(
            path: enums.RouteEnum.profile.path,
            redirect: (_, __) => deferredLoad(profile.loadLibrary),
            builder: (_, state) => profile.ProfileScreen(userTpe: state.queryParams["user_type"]),
          ),
        ],
      ),
    ],
  );

  return router..provider(provider);
}
