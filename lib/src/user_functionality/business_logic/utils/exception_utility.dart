import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mvvm_demo/src/user_functionality/business_logic/models/failure.dart';


Failure getCurrentFailure(error) {
  if (error is Exception) {
    try {
      Failure failure;
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            failure = Failure(error: error, errorMessage: "Request Cancelled");
            break;
          case DioErrorType.connectTimeout:
            failure = Failure(
                error: error, errorMessage: "Connection request timeout");
            break;
          case DioErrorType.other:
            failure =
                Failure(error: error, errorMessage: "No internet connection!");
            break;
          case DioErrorType.receiveTimeout:
            failure = Failure(
                error: error,
                errorMessage: "Send timeout in connection with API server");
            break;
          case DioErrorType.sendTimeout:
            failure = Failure(
                error: error,
                errorMessage: "Send timeout in connection with API server");
            break;
          case DioErrorType.response:
            switch (error.response!.statusCode) {
              case 400:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error, errorMessage: errorMessage ?? "Bad Request!");
                break;
              case 401:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage: errorMessage ?? "Unauthorised request!");
                break;
              case 403:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage:
                        errorMessage ?? "Not allowed to access this area!");
                break;
              case 404:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage: errorMessage ?? "Item not found!");
                break;
              case 408:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage: errorMessage ?? "Connection request timeout");
                break;
              case 409:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage: errorMessage ?? "Error due to a conflict!");
                break;
              case 422:
                final errorMessage = _getErrorMessage(error);
                failure = Failure(
                    error: error,
                    errorMessage: errorMessage ?? "Unprocessable Entity!");
                break;
              case 500:
                failure = Failure(
                    error: error, errorMessage: "Internal Server Error!");
                break;
              case 503:
                failure =
                    Failure(error: error, errorMessage: "Service unavailable!");
                break;
              default:
                final int? responseCode = error.response!.statusCode;
                failure = Failure(
                    error: error,
                    errorMessage:
                        "Received invalid status code: $responseCode");
            }
            break;
        }
      } else if (error is SocketException) {
        failure =
            Failure(error: error, errorMessage: "No internet connection!");
      } else if (error.toString().contains("is not a subtype of")) {
        failure = _unableToProcessDataFailure(error);
      } else if (error is FormatException) {
        failure = _formateExceptionFailure(error);
      } else {
        failure = _unexpectedErrorFailure(error);
      }

      return failure;
    } on FormatException catch (e) {
      return _formateExceptionFailure(e);
    } catch (e) {
      return _unexpectedErrorFailure(error);
    }
  } else {
    if (error.toString().contains("is not a subtype of")) {
      return _unableToProcessDataFailure(error);
    } else {
      return _unexpectedErrorFailure(error);
    }
  }
}

Failure _unableToProcessDataFailure(error) =>
    Failure(error: error, errorMessage: "Unable to process the data");

Failure _unexpectedErrorFailure(error) =>
    Failure(error: error, errorMessage: "Unexpected error occurred!");

Failure _formateExceptionFailure(FormatException error) {
  return Failure(
      error: error,
      errorMessage:
          "Data does not have an expected format and cannot be parsed or processed");
}

String getEnumValue(String name) {
  return name.toString().substring(name.toString().indexOf('.') + 1);
}

String? _getErrorMessage(error) {
  final response = error.response;
  if (response == null) return null;

  if (response.data is String) return jsonDecode(response.data)['error'];

  return response.data['error'] != null
      ? response.data['error']
      : response.data['message'];
}
