import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:qlevar_router/qlevar_router.dart' show QR, QRoute, QCustomPage, QPlatformPage;
import 'package:route_app/router/import.dart' show AppRouter;
import 'package:route_app/router/route_enum.dart' show RouteEnum;
import 'package:route_app/screens/404/import.dart' show NotFoundScreen, NotFoundController;
import 'package:route_app/screens/home/import.dart';
import 'package:route_app/screens/login/import.dart';
import 'package:route_app/screens/profile/import.dart';
import 'package:route_app/screens/user/import.dart';

Future<AppRouter> routesConfig(AppRouter router) async {
  // await Future.wait([
  //   loadLibrary(),
  //   loadLibrary(),
  //   loadLibrary(),
  //   loadLibrary(),
  // ]);

  QR.setUrlStrategy();

  QR.settings.enableDebugLog = !kReleaseMode;
  QR.settings.pagesType = kIsWeb ? const QCustomPage() : const QPlatformPage();

  QR.settings.notFoundPage = QRoute(
    path: RouteEnum.notFound.path,
    builder: () => NotFoundScreen(
      controller: NotFoundController(router: router),
    ),
  );

  final routes = <QRoute>[
    QRoute(
      path: '/${RouteEnum.login.path}',
      builder: () => LoginScreen(controller: LoginController(router: router)),
      middleware: [
        // deferredLoad(loadLibrary),
      ],
      // redirect: (_, __) => deferredLoad(loadLibrary),
      // builder: (_, __) => LoginScreen(controller: LoginController(router: router)),
    ),
    QRoute(
      path: RouteEnum.home.path,
      // redirect: (_, __) => deferredLoad(loadLibrary),
      // builder: (_, state) => HomeScreen(controller: HomeController(router: router)),
      builder: () => HomeScreen(controller: HomeController(router: router)),
      children: [
        QRoute(
          path: '${RouteEnum.user.path}/:id',
          // redirect: UserGuard(deferred: loadLibrary).redirect,
          builder: () {
            if (QR.params['id']?.hasValue ?? false) {
              throw Exception();
            }

            return UserScreen(
              id: QR.params['id']!.asInt!,
              name: QR.params['name']?.valueAs(),
              controller: UserController(router: router),
            );
          },
          // routes: [
          //   GoRoute(
          //     path: RouteEnum.profile.path,
          //     redirect: (_, __) => deferredLoad(loadLibrary),
          //     builder: (_, state) => ProfileScreen(userTpe: state.queryParams['user_type']),
          //   ),
          // ],
        ),
      ],
    ),
    QRoute(
      path: RouteEnum.profile.path,
      // redirect: (_, __) => deferredLoad(loadLibrary),
      // builder: (_, state) => ProfileScreen(userTpe: state.queryParams['user_type']),
      builder: () => ProfileScreen(userTpe: QR.params['user_type']?.valueAs()),
    ),
  ];

  return router..provider(QR, routes);
}
