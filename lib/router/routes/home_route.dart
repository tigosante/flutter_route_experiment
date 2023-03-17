import 'package:go_router/go_router.dart' show GoRoute;
import 'package:route_app/main/dependency_injection/dependency_injection.dart';
import 'package:route_app/router/import.dart' show RouteEnum, deferredLoad;
import 'package:route_app/router/routes/app_route.dart' show AppRoute;
import 'package:route_app/router/routes/profile_route.dart' show ProfileRoute;
import 'package:route_app/router/routes/user_route.dart' show UserRoute;
import 'package:route_app/screens/home/import.dart' deferred as home_screen show HomeScreen;
import 'package:route_app/screens/home/import.dart' deferred as home_controller show HomeController;

class HomeRoute implements AppRoute {
  HomeRoute({
    required DependencyInjection dependency,
  }) : _dependency = dependency;

  final DependencyInjection _dependency;

  Future<void> _loadBinds() async {
    await home_controller.loadLibrary();
    _dependency.setInstance(() => home_controller.HomeController(router: _dependency.get()));
    await home_screen.loadLibrary();

    return;
  }

  @override
  GoRoute route() {
    return GoRoute(
      path: RouteEnum.home.path,
      redirect: (_, __) => deferredLoad(_loadBinds),
      builder: (_, state) => home_screen.HomeScreen(controller: _dependency.get()),
      routes: [
        ProfileRoute().route(),
        UserRoute(dependency: _dependency).route(),
      ],
    );
  }
}
