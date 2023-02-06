import 'package:flutter/material.dart' show RouteInformationParser, RouterDelegate;
import 'package:qlevar_router/qlevar_router.dart' show QRoute, QRouteInformationParser, QRouterDelegate;
// ignore: implementation_imports
import 'package:qlevar_router/src/qr.dart' show QRContext;

mixin AppRouter {
  void provider(QRContext provider, List<QRoute> routes);
  RouterDelegate<Object>? get routerDelegate;
  RouteInformationParser<Object>? get routeInformationParser;

  void back();
  void navigate(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
    bool joinQueryParams = false,
  });

  void replaceAll(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
  });
}

class AppRouterConcrete implements AppRouter {
  static late QRContext _providerInstance;

  final List<QRoute> _routes = [];
  final String _symbolQueryParams = '?';

  @override
  RouterDelegate<Object>? get routerDelegate => QRouterDelegate(_routes);

  @override
  RouteInformationParser<Object>? get routeInformationParser => const QRouteInformationParser();

  @override
  void provider(QRContext provider, List<QRoute> routes) {
    _routes
      ..clear()
      ..addAll(routes);
    _providerInstance = provider;
  }

  @override
  void back() {
    _providerInstance.back();
  }

  @override
  void navigate(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
    bool joinQueryParams = false,
  }) {
    var routeFix = _fixRoutePath(route, params);

    final locationSplit = _splitRouteQueryParms(_providerInstance.currentPath);
    final location = locationSplit.first.endsWith('/') ? locationSplit.first.substring(1) : locationSplit.first;

    routeFix = location + routeFix;
    routeFix += _getQueryParams(routeFix, queryParams, paramsToJoin: joinQueryParams ? locationSplit.last : '');

    _providerInstance.navigator.push(routeFix);
  }

  @override
  void replaceAll(
    String route, {
    Map<String, dynamic> params = const {},
    Map<String, dynamic> queryParams = const {},
  }) {
    final routeFix = _fixRoutePath(route, params) + _getQueryParams(route, queryParams);
    _providerInstance.navigator.replaceAll(routeFix);
  }

  String _fixRoutePath(String route, Map<String, dynamic> params) {
    var routeFix = route.startsWith('/') ? route : '/$route';
    if (params.isNotEmpty) routeFix += "/${params.values.join("/")}";

    return routeFix;
  }

  String _getQueryParams(String route, Map<String, dynamic> queryParams, {String paramsToJoin = ''}) {
    final params = _queryParams(route, queryParams, paramsToJoin: paramsToJoin);
    if (params.isNotEmpty) return _symbolQueryParams + params;
    return params;
  }

  String _queryParams(String route, Map<String, dynamic> queryParams, {String paramsToJoin = ''}) {
    final currentParams = _splitRouteQueryParms(route).last;

    if (queryParams.isNotEmpty) {
      final params = <String>[];
      queryParams.forEach((key, value) => params.add('$key=$value'));

      return _joinMultQueryParams([currentParams, _joinMultQueryParams(params), paramsToJoin]);
    }

    if (currentParams.isNotEmpty) {
      return _joinMultQueryParams([currentParams, paramsToJoin]);
    }

    return paramsToJoin;
  }

  List<String> _splitRouteQueryParms(String value) {
    const patternReplaceSplit = 'replace_here';
    final values = value.replaceFirst(_symbolQueryParams, patternReplaceSplit).split(patternReplaceSplit);

    if (values.length == 1) return values..add('');
    return values;
  }

  String _joinMultQueryParams(List<String> values) {
    if (values.isEmpty) return '';

    values.removeWhere((element) => element.isEmpty);
    if (values.length == 1) return values.first;

    return values.join('&');
  }
}
