import 'package:route_app/router/import.dart' show AppRouter, RouteEnum;

class LoginController {
  LoginController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void login() {
    _router.replaceAll(RouteEnum.home.path, queryParams: {"from": "login"});
  }
}
