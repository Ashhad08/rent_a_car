import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../configurations/error_messages.dart';

class NetworkRepository {
  final ErrorMessages _errorMessages;

  NetworkRepository({
    required ErrorMessages errorMessages,
  }) : _errorMessages = errorMessages;

  Future<dynamic> get({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }
      final res = await http
          .get(uri, headers: headers)
          .timeout(const Duration(minutes: 1));
      return _handleResponse(res.statusCode, res.body, res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }
      final res = await http
          .post(
            uri,
            headers: headers,
            body: data != null ? jsonEncode(data) : null,
          )
          .timeout(const Duration(minutes: 3));
      return _handleResponse(res.statusCode, res.body, res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }
      final res = await http
          .put(
            uri,
            headers: headers,
            body: data != null ? jsonEncode(data) : null,
          )
          .timeout(const Duration(minutes: 3));
      return _handleResponse(res.statusCode, res.body, res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }
      final res = await http
          .delete(
            uri,
            headers: headers,
            body: data != null ? jsonEncode(data) : null,
          )
          .timeout(const Duration(minutes: 3));
      return _handleResponse(res.statusCode, res.body, res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }

  dynamic _handleResponse(
    int statusCode,
    dynamic body,
    String? reasonPhrase,
  ) {
    try {
      body = jsonDecode(body);
    } catch (e) {
      body = body.toString();
    }
    switch (statusCode) {
      case 200:
        return body;
      case 201:
        return body;

      case 400:
        throw _errorMessages.badRequestException;

      case 401:
        throw _errorMessages.unauthorizedException;

      case 403:
        throw _errorMessages.forbiddenException;

      case 404:
        throw _errorMessages.notFoundException;

      case 408:
        throw _errorMessages.requestTimeoutException;

      case 500:
        throw _errorMessages.internalServerException;

      case 502:
        throw _errorMessages.badGatewayException;

      case 503:
        throw _errorMessages.serviceUnavailableException;

      case 504:
        throw _errorMessages.gatewayTimeoutException;

      default:
        throw reasonPhrase ??
            'An unexpected error occurred. Please try again later.';
    }
  }

  Future<dynamic> postFormData({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? fields,
    List<String>? filePaths,
    String fileFieldName = 'File',
    String? bearerToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }

      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.headers.addAll(headers);
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (filePaths != null) {
        final List<http.MultipartFile> files = await Future.wait(filePaths.map(
          (e) => http.MultipartFile.fromPath(fileFieldName, e),
        ));
        request.files.addAll(files);
      }

      http.StreamedResponse res = await request.send();
      return _handleResponse(
          res.statusCode, (await res.stream.bytesToString()), res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putFormData({
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? fields,
    List<String>? filePaths,
    String fileFieldName = 'File',
    String? bearerToken,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
      };
      if (queryParameters != null) {
        uri = uri.replace(
          queryParameters: queryParameters
              .map((key, value) => MapEntry(key, value.toString())),
        );
      }

      final request = http.MultipartRequest(
        'PUT',
        uri,
      );
      request.headers.addAll(headers);
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (filePaths != null) {
        final List<http.MultipartFile> files = await Future.wait(filePaths.map(
          (e) => http.MultipartFile.fromPath(fileFieldName, e),
        ));
        request.files.addAll(files);
      }

      http.StreamedResponse res = await request.send();
      return _handleResponse(
          res.statusCode, (await res.stream.bytesToString()), res.reasonPhrase);
    } on SocketException {
      throw _errorMessages.noInternetException;
    } on TimeoutException {
      throw _errorMessages.timeOutException;
    } on HttpException {
      throw _errorMessages.httpException;
    } on FormatException {
      throw _errorMessages.formatException;
    } catch (e) {
      rethrow;
    }
  }
}
