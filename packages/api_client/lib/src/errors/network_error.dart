import 'package:dio/dio.dart';

class NetworkError implements DioError {
  @override
  dynamic error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => _message!;

  String? _message;

  NetworkError(DioError err)
      : requestOptions = err.requestOptions,
        response = err.response,
        type = err.type,
        error = err.error {
    final response = this.response;
    stackTrace = err.stackTrace;
    if (response is Response) {
      final data = response.data;
      if (data is Map) {
        final message = data['message'];
        if (message is String) {
          _message = message;
        }
      }
    }
    _message ??= err.message;
  }

  @override
  String toString() {
    var stack = '';
    if (response?.data is Map<String, dynamic>) {
      stack = ', stack="${response?.data?['stack']}"';
    }
    return '<NetworkError type=$type statusCode=${response?.statusCode} message="$_message"$stack>';
  }
}
