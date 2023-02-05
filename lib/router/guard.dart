import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouterState;

mixin AppRouterGuards {
  Future<String?> redirect({
    required BuildContext context,
    required GoRouterState state,
    required Future<void> Function() deferredLoading,
  });
}
