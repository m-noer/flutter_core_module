import 'package:core_module/src/network/http_client.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> init() async {
  // Dio
  inject.registerFactory(() => inject<HttpClient>().dio);
}
