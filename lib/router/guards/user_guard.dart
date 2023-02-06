// import 'package:flutter/material.dart' show BuildContext;
// import 'package:go_router/go_router.dart' show GoRouterState;
// import 'package:route_app/router/guards/app_route_guard.dart' show AppRouterGuard, deferredLoad;

// class UserGuard implements AppRouterGuard {
//   UserGuard({required Future<void> Function() deferred}) : _deferred = deferred;

//   final Future<void> Function() _deferred;

//   @override
//   Future<String?> redirect(BuildContext context, GoRouterState state) async {
//     final id = int.tryParse(state.params['id'] ?? 'empty');
//     if (id == null) return '${state.subloc}/not-found';

//     return deferredLoad(_deferred);
//   }
// }
