import 'package:route_app/router/import.dart' show AppRouter, RouteEnum;

class HomeController {
  HomeController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void gotToUser() {
    _router.navigate(RouteEnum.user.path, params: {'id': 1}, queryParams: {'name': 'tiago'});
  }

  void gotToProfile() {
    _router.navigate(RouteEnum.profile.path);
  }
}
