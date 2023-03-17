import 'package:go_router/go_router.dart' show GoRoute;
import 'package:route_app/main/dependency_injection/dependency_injection.dart';
import 'package:route_app/router/import.dart' show RouteEnum, deferredLoad;
import 'package:route_app/router/routes/app_route.dart' show AppRoute;
import 'package:route_app/router/routes/profile_route.dart' show ProfileRoute;
import 'package:route_app/screens/user/import.dart' deferred as user_screen show UserScreen;
import 'package:route_app/screens/user/import.dart' deferred as user_controller show UserController;

class UserRoute implements AppRoute {
  UserRoute({
    required DependencyInjection dependency,
  }) : _dependency = dependency;

  final DependencyInjection _dependency;

  Future<void> _loadBinds() async {
    await user_controller.loadLibrary();
    _dependency.setInstance(() => user_controller.UserController(router: _dependency.get()));
    await user_screen.loadLibrary();
  }

  @override
  GoRoute route() {
    return GoRoute(
      path: '${RouteEnum.user.path}/:id',
      redirect: (_, __) => deferredLoad(_loadBinds),
      builder: (_, state) => user_screen.UserScreen(
        name: state.queryParams['name'],
        id: int.tryParse(state.params['id']!)!,
        controller: _dependency.get(),
      ),
      routes: [
        ProfileRoute().route(),
      ],
    );
  }
}
