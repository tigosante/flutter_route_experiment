import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouterState;
import 'package:route_app/router/guard.dart' show AppRouterGuards;

class UserGuards implements AppRouterGuards {
  @override
  Future<String?> redirect({
    required BuildContext context,
    required GoRouterState state,
    required Future<void> Function() deferredLoading,
  }) async {
    final id = int.tryParse(state.params["id"] ?? "s");

    if (id == null) return "${state.subloc}/not-found";
    await deferredLoading();

    return null;
  }
}
