import 'package:route_app/router/app_router.dart' show AppRouter;

class ProfileController {
  ProfileController({
    required AppRouter router,
  }) : _router = router;

  final AppRouter _router;

  void back() {
    _router.back();
  }
}
