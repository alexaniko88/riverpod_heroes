part of '../shared.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Result<NetworkResponse, AppException>> handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      final res = await handler();
      return Success(
        NetworkResponse(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      log(e.runtimeType.toString());
      switch (e.runtimeType) {
        case SocketException _:
          e as SocketException;
          message = 'Unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at  $endpoint';
          break;

        case DioException _:
          e as DioException;
          message = e.response?.data?['message'] ?? 'Internal Error occurred';
          statusCode = 1;
          identifier = 'DioException ${e.message} \nat  $endpoint';
          break;

        default:
          message = 'Unknown error occurred';
          statusCode = 2;
          identifier = 'Unknown error ${e.toString()}\n at $endpoint';
      }
      return Failure(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
