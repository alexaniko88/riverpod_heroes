part of '../../shared.dart';

@riverpod
NetworkService networkService(NetworkServiceRef ref) => DioNetworkService(Dio());
