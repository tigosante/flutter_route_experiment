import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouterState;
import 'package:route_app/router/guards/app_route_guard.dart' show AppRouterGuard;

class UserGuard extends AppRouterGuard {
  @override
  Future<String?> redirect({
    required BuildContext context,
    required GoRouterState state,
    required Future<void> Function() deferredLoading,
  }) async {
    final id = int.tryParse(state.params["id"] ?? "empty");
    if (id == null) return "${state.subloc}/not-found";

    return await AppRouterGuard.deferred(deferredLoading);
  }
}
