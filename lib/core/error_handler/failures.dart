import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          'Connection timeout with ApiServer, Please try later',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer, Please try later');
      case DioExceptionType.receiveTimeout:
        return  ServerFailure(
          'Receive timeout with ApiServer, Please try later',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          'Request to ApiServer was cancelled, Please try later',
        );
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
      case DioExceptionType.badCertificate:
        return ServerFailure(
          'Secure connection failed, Please try again later',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          'Connection error with ApiServer, Please check your internet and try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
