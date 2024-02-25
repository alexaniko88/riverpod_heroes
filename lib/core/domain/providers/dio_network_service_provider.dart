part of '../../core.dart';

@riverpod
NetworkService networkService(NetworkServiceRef ref) => DioNetworkService(Dio());
