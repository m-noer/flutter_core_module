import 'package:core_module/src/network/http_client.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> init() async {
  // Core
  inject.registerFactory(() => inject<HttpClient>().dio);
  inject.registerFactory(() => HttpClient());
}
