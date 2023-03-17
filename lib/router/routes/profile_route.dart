import 'package:go_router/go_router.dart' show GoRoute;
import 'package:route_app/router/import.dart' show RouteEnum, deferredLoad;
import 'package:route_app/router/routes/app_route.dart' show AppRoute;
import 'package:route_app/screens/profile/import.dart' deferred as profile_screen show ProfileScreen;

class ProfileRoute implements AppRoute {
  @override
  GoRoute route() {
    return GoRoute(
      path: RouteEnum.profile.path,
      redirect: (_, __) => deferredLoad(profile_screen.loadLibrary),
      builder: (_, __) => profile_screen.ProfileScreen(),
    );
  }
}
