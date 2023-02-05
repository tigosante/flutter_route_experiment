import 'package:route_app/router/app_router.dart' show AppRouter, RouteEnum;

class HomeController {
  HomeController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void gotToUser() {
    _router.navigate(RouteEnum.user.path);
  }

  void gotToProfile() {
    _router.navigate(RouteEnum.profile.path);
  }
}
