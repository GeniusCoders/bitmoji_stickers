import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class BaseModel<T> {
  ServerError? _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  get getException {
    return _error;
  }
}

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({required dynamic error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioExceptionType.cancel:
          _errorMessage = "Request was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          _errorMessage = "Connection timeout";
          break;
        case DioExceptionType.unknown:
          _errorMessage = "Connection failed due to internet connection";
          break;
        case DioExceptionType.receiveTimeout:
          _errorMessage = "Receive timeout in connection";
          break;
        case DioExceptionType.badResponse:
          _errorMessage =
              "Received invalid status code: ${error.response!.statusCode}";
          break;
        case DioExceptionType.sendTimeout:
          _errorMessage = "Receive timeout in send request";
          break;
        case DioExceptionType.badCertificate:
          _errorMessage = "Connection failed due to internet connection";
          break;
        case DioExceptionType.connectionError:
          _errorMessage = "Connection failed due to internet connection";
          break;
      }
    } else if (error is SocketException) {
      _errorMessage = "Connection failed due to internet connection";
    } else if (error is String) {
      _errorMessage = error;
    } else if (error is PlatformException) {
      _errorMessage = error.message ?? "Something went wrong";
    } else {
      _errorMessage = "Something went wrong";
    }

    return _errorMessage;
  }
}
