import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message:
                "Connection timed out. Please check your internet connection.",
          );
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to the server failed ");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data, error.response?.statusCode);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request was cancelled");
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message:
                "Connection to the server failed, due to internet connection",
          );
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    }
    return ApiErrorModel(message: "Unknown error occurred");
  }

  static ApiErrorModel _handleError(dynamic data, int? statusCode) {
    return ApiErrorModel(
      message: data['message'] ?? "Unknown error occurred",
      code: statusCode,
      errors: data['errors'],
    );
  }
}
