import 'package:route_app/router/app_router.dart' show AppRouter, RouteEnum;

class NotFoundController {
  NotFoundController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void gotToHome() {
    _router.replaceAll(RouteEnum.home.path);
  }
}
