import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.iconfig.dart';

final getIt = GetIt.instance;

@injectableInit
void configure(String env) {
  $initGetIt(getIt, environment: env);
}
