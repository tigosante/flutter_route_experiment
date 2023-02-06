import 'package:route_app/router/import.dart' show AppRouter, RouteEnum;

class UserController {
  UserController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void gotToProfile() {
    _router.navigate(
      RouteEnum.profile.path,
      joinQueryParams: true,
      queryParams: {'user_type': 'adm'},
    );
  }
}
