import 'package:go_router/go_router.dart' show GoRoute;
import 'package:route_app/main/dependency_injection/dependency_injection.dart';
import 'package:route_app/router/import.dart' show RouteEnum, deferredLoad;
import 'package:route_app/router/routes/app_route.dart' show AppRoute;
import 'package:route_app/screens/login/import.dart' deferred as login_screen show LoginScreen;
import 'package:route_app/screens/login/import.dart' deferred as login_controller show LoginController;

class LoginRoute implements AppRoute {
  LoginRoute({
    required DependencyInjection dependency,
  }) : _dependency = dependency;

  final DependencyInjection _dependency;

  Future<void> _loadBinds() async {
    await login_controller.loadLibrary();
    _dependency.setInstance(() => login_controller.LoginController(router: _dependency.get()));
    await login_screen.loadLibrary();
  }

  @override
  GoRoute route() {
    return GoRoute(
      path: '/${RouteEnum.login.path}',
      redirect: (_, __) => deferredLoad(_loadBinds),
      builder: (_, __) => login_screen.LoginScreen(controller: _dependency.get()),
    );
  }
}
