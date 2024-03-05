part of '../../shared.dart';

@Riverpod(keepAlive: true)
NetworkService networkService(NetworkServiceRef ref) => DioNetworkService(Dio());
