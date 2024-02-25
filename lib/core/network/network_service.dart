part of '../core.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  Future<Result<NetworkResponse, AppException>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
