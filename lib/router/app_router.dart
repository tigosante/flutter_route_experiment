import 'package:flutter/material.dart' show RouteInformationParser, RouterDelegate;
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;
import 'package:route_app/screens/404/not_found_controller.dart' show NotFoundController;
import 'package:route_app/screens/404/not_found_screen.dart' show NotFoundScreen;
import 'package:route_app/screens/home/home_controller.dart' show HomeController;
import 'package:route_app/screens/home/home_screen.dart' show HomeScreen;
import 'package:route_app/screens/login/login_controller.dart' show LoginController;
import 'package:route_app/screens/login/login_screen.dart' show LoginScreen;
import 'package:route_app/screens/profile/profile_controller.dart' show ProfileController;
import 'package:route_app/screens/profile/profile_screen.dart' show ProfileScreen;
import 'package:route_app/screens/user/user_controller.dart' show UserController;
import 'package:route_app/screens/user/user_screen.dart' show UserScreen;

enum RouteEnum {
  home("/", "home"),
  user("user", "user"),
  profile("profile", "profile"),
  login("login", "login"),
  notFound("404", "notFound");

  final String path;
  final String name;

  const RouteEnum(this.path, this.name);
}

mixin AppRouter {
  RouterDelegate<Object>? get routerDelegate;
  RouteInformationParser<Object>? get routeInformationParser;

  void back();
  void navigate(String route);
  void replaceAll(String route);
}

class AppRouterConcrete implements AppRouter {
  @override
  RouterDelegate<Object>? get routerDelegate => _provider.routerDelegate;

  @override
  RouteInformationParser<Object>? get routeInformationParser => _provider.routeInformationParser;

  GoRouter get _provider => GoRouter(
        initialLocation: RouteEnum.home.path,
        errorBuilder: (_, __) => NotFoundScreen(
          controller: NotFoundController(router: this),
        ),
        routes: [
          GoRoute(
            path: "/" + RouteEnum.login.path,
            builder: (_, __) => LoginScreen(
              controller: LoginController(router: this),
            ),
          ),
          GoRoute(
            path: RouteEnum.home.path,
            builder: (_, state) => HomeScreen(
              controller: HomeController(router: this),
            ),
            routes: [
              GoRoute(
                path: RouteEnum.user.path,
                builder: (_, __) => UserScreen(
                  controller: UserController(router: this),
                ),
                routes: [
                  GoRoute(
                    path: RouteEnum.profile.path,
                    builder: (_, __) => ProfileScreen(
                      controller: ProfileController(router: this),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  @override
  void back() {
    _provider.pop();
  }

  @override
  void navigate(String route) {
    _provider.go(route.startsWith("/") ? route : "/" + route);
  }

  @override
  void replaceAll(String route) {
    _provider.pushReplacement(route.startsWith("/") ? route : "/" + route);
  }
}
