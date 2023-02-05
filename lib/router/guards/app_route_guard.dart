import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouterState;

abstract class AppRouterGuard {
  Future<String?> redirect({
    required BuildContext context,
    required GoRouterState state,
    required Future<void> Function() deferredLoading,
  });

  static Future<String?> deferred(Future<void> Function() deferredLoading) async {
    await deferredLoading();
    return null;
  }
}
