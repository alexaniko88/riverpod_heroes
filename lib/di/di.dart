import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_heroes/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)
void setupDependencies(String env) => getIt.init(environment: env);
