import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart' show RouteInformationParser;
import 'package:qlevar_router/qlevar_router.dart'
    show QCustomPage, QMiddlewareBuilder, QPlatformPage, QR, QRoute, QRouteInformationParser;
import 'package:route_app/router/deferred_guard.dart' show DeferredLoader;
import 'package:route_app/screens/404/not_found_screen.dart' show NotFoundScreen;
import 'package:route_app/screens/home/home_controller.dart' show HomeController;
import 'package:route_app/screens/home/home_screen.dart' deferred as home_screen show HomeScreen;
import 'package:route_app/screens/profile/profile_screen.dart' show ProfileScreen;
import 'package:route_app/screens/store/store_screen.dart' show StoreScreen;
import 'package:route_app/screens/user/user_controller.dart' show UserController;
import 'package:route_app/screens/user/user_screen.dart' deferred as user_screen show UserScreen;

enum RouteEnum {
  home("/home", "home"),
  user("/user", "user"),
  profile("/profile", "profile"),
  store("/store", "store"),
  notFound("/404", "notFound");

  final String path;
  final String name;

  const RouteEnum(this.path, this.name);
}

mixin AppRouter {
  List<QRoute> get routes;
  RouteInformationParser<Object>? get routeInformationParser;

  void setup();
  void navigate(String route);
  void replace(String route);
  void back();
}

class AppRouterConcrete implements AppRouter {
  @override
  RouteInformationParser<Object>? get routeInformationParser => const QRouteInformationParser();

  @override
  List<QRoute> get routes => [
        QRoute(
          path: RouteEnum.home.path,
          name: RouteEnum.home.name,
          builder: () => home_screen.HomeScreen(
            controller: HomeController(router: this),
          ),
          children: [_profileRoute],
          middleware: [
            DeferredLoader(home_screen.loadLibrary),
          ],
        ),
        QRoute.withChild(
          path: RouteEnum.user.path,
          name: RouteEnum.user.name,
          builderChild: (router) => user_screen.UserScreen(
            controller: UserController(router: this),
          ),
          children: [_profileRoute],
          middleware: [
            DeferredLoader(user_screen.loadLibrary),
            QMiddlewareBuilder(
              onEnterFunc: () async => print('-- Enter Parent page --'),
              onExitFunc: () async => print('-- Exit Parent page --'),
              onMatchFunc: () async => print('-- Parent page Matched --'),
            ),
          ],
        ),
        QRoute.withChild(
          path: RouteEnum.store.path,
          name: RouteEnum.store.name,
          builderChild: (router) => StoreScreen(),
          children: [_profileRoute],
        ),
      ];

  QRoute get _profileRoute => QRoute(
        path: RouteEnum.profile.path,
        name: RouteEnum.profile.name,
        builder: ProfileScreen.new,
      );

  @override
  void setup() {
    QR.setUrlStrategy();

    QR.settings.enableDebugLog = !kReleaseMode;
    QR.settings.pagesType = kIsWeb ? QCustomPage() : QPlatformPage();

    QR.settings.notFoundPage = QRoute(
      path: RouteEnum.notFound.path,
      builder: NotFoundScreen.new,
    );
  }

  @override
  void navigate(String route) {
    final newPath = QR.currentPath + route;
    QR.navigator.push(newPath);
  }

  @override
  void replace(String route) {
    QR.navigator.push(route);
  }

  @override
  void back() {
    QR.back();
  }
}
