import 'package:route_app/router/app_router.dart' show AppRouter, RouteEnum;

class UserController {
  UserController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void back() {
    _router.back();
  }

  void gotToProfile() {
    _router.navigate(RouteEnum.profile.path);
  }
}
