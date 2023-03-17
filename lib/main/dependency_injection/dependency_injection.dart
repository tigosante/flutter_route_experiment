import 'package:get_it/get_it.dart';

mixin DependencyInjection {
  T get<T extends Object>();
  void setInstance<T extends Object>(T Function() instance, {InstanceType instanceType = InstanceType.lazy});
}

class DependencyInjectionImpl implements DependencyInjection {
  DependencyInjectionImpl({
    required GetIt provider,
  }) : _provider = provider {
    provider.registerSingleton(this);
  }

  final GetIt _provider;

  @override
  T get<T extends Object>() => _provider<T>();

  @override
  void setInstance<T extends Object>(T Function() instance, {InstanceType instanceType = InstanceType.lazy}) {
    if (_provider.isRegistered<T>()) return;

    switch (instanceType) {
      case InstanceType.singleton:
        _provider.registerSingleton<T>(instance());
        break;
      case InstanceType.lazy:
        _provider.registerLazySingleton<T>(instance);
        break;
    }
  }
}

enum InstanceType {
  lazy,
  singleton;
}
