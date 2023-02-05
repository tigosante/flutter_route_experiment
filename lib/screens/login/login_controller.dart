import 'package:route_app/router/app_router.dart' show AppRouter, RouteEnum;

class LoginController {
  LoginController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void login() {
    _router.replaceAll(RouteEnum.user.path);
  }
}
