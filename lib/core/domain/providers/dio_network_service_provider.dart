part of '../../core.dart';

@riverpod
NetworkService networkService(NetworkServiceRef ref) {
  final Dio dio = Dio();
  return DioNetworkService(dio);
}
