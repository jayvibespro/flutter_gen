import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Global instance of GetIt.
final getIt = GetIt.instance;

/// This function initiates your Injection configuration. call it once in your main function
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true,
)
void initDependencies() => getIt.init();
