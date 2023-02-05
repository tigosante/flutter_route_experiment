import 'package:flutter/material.dart';
import 'package:route_app/application.dart' show Application;
import 'package:route_app/router/app_router.dart' show AppRouterConcrete;

void main() {
  final router = AppRouterConcrete();
  runApp(Application(router: router));
}
