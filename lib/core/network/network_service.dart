part of '../core.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Result<NetworkResponse, AppException>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
