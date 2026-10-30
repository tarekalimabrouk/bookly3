
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          'Connection timeout with ApiServer',
        );

      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'Send timeout with ApiServer',
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'Receive timeout with ApiServer',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure(
          'Request to ApiServer was cancelled',
        );

      case DioExceptionType.connectionError:
        return const ServerFailure(
          'No Internet Connection',
        );

      default:
        return ServerFailure(
          'Unexpected Error: ${dioError.message}',
        );
    }
  }

  factory ServerFailure.fromResponse(
    int? statusCode,
    dynamic response,
  ) {
   
if (statusCode == 400 ||
    statusCode == 401 ||
    statusCode == 403) {
  String message = 'Request failed: $statusCode';

  if (response is Map) {
    final error = response['error'];

    if (error is Map && error['message'] != null) {
      message = error['message'].toString();
    }
  }

 
      return ServerFailure(
        message?.toString() ?? 'Request failed: $statusCode',
      );
    } else if (statusCode == 404) {
      return const ServerFailure(
        'Your request not found, Please try later!',
      );
    } else if (statusCode != null && statusCode >= 500) {
      return const ServerFailure(
        'Internal Server error, Please try later',
      );
    } else {
      return ServerFailure(
        'Oops! There was an Error. Status: $statusCode',
      );
    }
  }
}