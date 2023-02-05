import 'package:flutter/foundation.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DeferredLoader extends QMiddleware {
  DeferredLoader(this._loader);

  final Future<dynamic> Function() _loader;

  @override
  Future<dynamic> onEnter() async {
    await _loader();
    if (kDebugMode) print('deferred loaded screen');
  }
}
