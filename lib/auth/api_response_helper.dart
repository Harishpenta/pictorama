import 'package:pictorama/core/error/exceptions.dart';

class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final AppException? error;

  ApiResponse({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse<T>(isSuccess: true, data: data);
  }

  factory ApiResponse.error(AppException error) {
    return ApiResponse<T>(isSuccess: false, error: error);
  }

  @override
  String toString() {
    return 'ApiResponse{isSuccess: $isSuccess, data: $data, error: $error}';
  }
}
