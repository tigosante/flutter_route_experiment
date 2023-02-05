import 'package:flutter/foundation.dart' show kReleaseMode, protected;
import 'package:flutter/material.dart' show RouteInformationParser, RouterDelegate;
import 'package:go_router/go_router.dart' show GoRoute, GoRouter;
import 'package:route_app/router/user_guards.dart' show UserGuards;
import 'package:route_app/screens/404/not_found_controller.dart' show NotFoundController;
import 'package:route_app/screens/404/not_found_screen.dart' show NotFoundScreen;
import 'package:route_app/screens/home/home_controller.dart' show HomeController;
import 'package:route_app/screens/home/home_screen.dart' show HomeScreen;
import 'package:route_app/screens/login/login_controller.dart' show LoginController;
import 'package:route_app/screens/login/login_screen.dart' show LoginScreen;
import 'package:route_app/screens/profile/profile_screen.dart' show ProfileScreen;
import 'package:route_app/screens/user/user_controller.dart' show UserController;
import 'package:route_app/screens/user/user_screen.dart' deferred as user_screen show UserScreen;

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
  void navigate(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
    bool joinQueryParams = false,
  });

  void replaceAll(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
  });
}

class AppRouterConcrete implements AppRouter {
  static GoRouter? _providerInstance;

  @override
  RouterDelegate<Object>? get routerDelegate => _provider.routerDelegate;

  @override
  RouteInformationParser<Object>? get routeInformationParser => _provider.routeInformationParser;

  GoRouter get _provider {
    return _providerInstance ??
        (_providerInstance = GoRouter(
          debugLogDiagnostics: !kReleaseMode,
          initialLocation: RouteEnum.home.path,
          errorBuilder: (_, state) => NotFoundScreen(
            message: state.error,
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
                  path: RouteEnum.user.path + "/:id",
                  redirect: (context, state) async => UserGuards().redirect(
                    state: state,
                    context: context,
                    deferredLoading: user_screen.loadLibrary,
                  ),
                  builder: (_, state) {
                    return user_screen.UserScreen(
                      id: int.tryParse(state.params["id"]!)!,
                      controller: UserController(router: this),
                      name: state.queryParams["name"],
                    );
                  },
                  routes: [
                    GoRoute(
                      path: RouteEnum.profile.path,
                      builder: (_, state) => ProfileScreen(userTpe: state.queryParams["user_type"]),
                    ),
                  ],
                ),
                GoRoute(
                  path: RouteEnum.profile.path,
                  builder: (_, __) => ProfileScreen(),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  void back() {
    _provider.pop();
  }

  @override
  void navigate(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
    bool joinQueryParams = false,
  }) {
    route = _fixRoutePath(route, params);

    const symbol = "?";
    String currentQueryParams = "";
    String location = _provider.location;

    if (location.contains(symbol)) {
      final locationSplit = _split(location, symbol);
      location = locationSplit.first;

      if (joinQueryParams) currentQueryParams = locationSplit.last;
    }

    route = location + (location.endsWith("/") ? route.substring(1) : route);
    route += _getQueryParams(route, queryParams, paramsToJoin: currentQueryParams);

    _provider.push(route);
  }

  @protected
  void replaceAll(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
  }) {
    route = _fixRoutePath(route, params) + _getQueryParams(route, queryParams);
    _provider.pushReplacement(route);
  }

  String _fixRoutePath(String route, Map<String, dynamic> params) {
    route = route.startsWith("/") ? route : "/" + route;
    if (params.isNotEmpty) route += "/" + params.values.join("/");
    return route;
  }

  String _getQueryParams(String route, Map<String, dynamic> queryParams, {String paramsToJoin = ""}) {
    const symbol = "?";
    const symbolJoin = "&";
    String currentParams = "";

    if (route.contains(symbol)) currentParams = _split(route, symbol).last;

    if (queryParams.isEmpty) {
      if (currentParams.isEmpty) {
        return paramsToJoin.isEmpty ? "" : symbol + paramsToJoin;
      }

      return symbol + _joinStrings([currentParams, paramsToJoin], symbolJoin);
    }

    final params = <String>[];
    queryParams.forEach((key, value) => params.add("$key=$value"));

    if (currentParams.isNotEmpty) params.insert(0, currentParams);

    return symbol + _joinStrings([params.join(symbolJoin), paramsToJoin], symbolJoin);
  }

  List<String> _split(String value, String pattern) {
    final patternReplaceSplit = "replace_here";
    return value.replaceFirst(pattern, patternReplaceSplit).split(patternReplaceSplit);
  }

  String _joinStrings(List<String> values, String joinValue) {
    if (values.isEmpty) return "";

    values.removeWhere((element) => element.isEmpty);
    if (values.length == 1) return values.first;

    return values.join(joinValue);
  }
}
