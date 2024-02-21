part of '../core.dart';

class AppException implements Exception {
  AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });
  final String message;
  final int statusCode;
  final String identifier;
  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }

  Failure<NetworkResponse, AppException> get asFailure =>
      Failure<NetworkResponse, AppException>(this);
}
