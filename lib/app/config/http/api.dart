import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../environment.dart';
import '../local_storage/local_storage.dart';
import 'app_exceptions.dart';

enum HttpMethod { get, post, put, delete }

class Api {
  final Client _client;
  final LocalStorage _localStorage;

  Api({
    required Client client,
    required LocalStorage localStorage,
  })  : _client = client,
        _localStorage = localStorage;

  late String _token;
  final _duration = const Duration(minutes: 2);

  final _logger = Logger();

  Uri _initUri({
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) {
    _token = _localStorage.token;

// http://103.23.60.24:3010/api/docs

    // Uri baseUri = Uri.parse('https://bolita-railway-production.up.railway.app');
    // Uri uri = baseUri.replace(
    //   path: '/api/v1/$url',
    //   queryParameters: queryParameters,
    // );

    Uri baseUri = Uri.parse(Environment.i.apiUrl);
    // Uri baseUri = Uri.parse('https://backend-dev-qodm.onrender.com');
    Uri uri = baseUri.replace(
      path: '/api/$url',
      queryParameters: queryParameters,
    );

    // final uri = Uri(
    //   scheme: 'https',
    //   host: 'backend-production-4e55.up.railway.app',
    //   path: '/api/v1/$url',
    //   queryParameters: queryParameters,
    // );
    return uri;
  }

  Future<Response> request({
    HttpMethod httpMethod = HttpMethod.get,
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    String? requestName,
  }) async {
    final uri = _initUri(
      url: url,
      body: body,
      queryParameters: queryParameters,
    );

    Map<String, dynamic> logs = {
      'requestName': requestName,
      'requestUrl': url,
      'url': uri,
      'method': httpMethod.name,
      'body': body,
      if (queryParameters != null) 'queryParameters': queryParameters,
    };

    try {
      late Response response;

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };

      // log('Token:${_token}');

      switch (httpMethod) {
        case HttpMethod.get:
          response = await _client
              .get(
                uri,
                headers: headers,
              )
              .timeout(_duration);
          break;

        case HttpMethod.post:
          response = await _client
              .post(
                uri,
                body: body,
                headers: headers,
              )
              .timeout(_duration);
          break;

        case HttpMethod.put:
          response = await _client
              .put(
                uri,
                body: body,
                headers: headers,
              )
              .timeout(_duration);
          break;
        case HttpMethod.delete:
          response = await _client
              .delete(
                uri,
                body: body,
                headers: headers,
              )
              .timeout(_duration);
          break;
      }

      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': response.statusCode.toString(),
        'responseBody': response.body,
        'token':_token
      };

      return response;
    } catch (e) {
      logs = {
        ...logs,
        'exception': e.toString(),
      };
      if (e is SocketException ||
          e is ClientException ||
          e is TimeoutException) {
        throw FetchDataException();
      } else {
        throw FetchDataException();
      }
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      _logger.log(Level.info,
          '🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀');
      _logger.log(Level.info, logs);
      _logger.log(Level.info,
          '🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀');
    }
  }

  Future<Response> uploadFormData({
    required String url,
    String? fieldName,
    List<File>? files,
    Map<String, String>? fields,
    final String? requestName,
  }) async {
    final uri = _initUri(url: url);

    Map<String, dynamic> logs = {
      'requestName': requestName,
      'requestUrl': url,
      'url': uri,
      'method': 'Post Multipart',
      'fields': fields,
      'fieldName': fieldName,
      if (files != null) '# files': files.length,
    };

    final request = MultipartRequest('POST', uri);

    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer $_token',
    });

    // Agregar campos adicionales si los hay
    if (fields != null) {
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }

    _logger.e('request.fields: ${request.fields}');

    // Agregar archivo

    if (files != null) {
      if (files.isNotEmpty) {
        for (var file in files) {
          final stream = ByteStream(file.openRead());
          final length = await file.length();
          final multipartFile = MultipartFile(
            fieldName!,
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
        }
      }
    }

    _logger.e('request.files: ${request.files}');

    final streamedResponse = await request.send();

    try {
      final response = await Response.fromStream(streamedResponse);
      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': response.statusCode.toString(),
        'responseBody': response.body,
      };

      _logger.log(Level.info, logs);

      return response;
    } catch (e) {
      logs = {
        ...logs,
        'exception': e.toString(),
      };
      if (e is SocketException ||
          e is ClientException ||
          e is TimeoutException) {
        throw FetchDataException();
      } else {
        throw FetchDataException();
      }
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      _logger.log(Level.info,
          '🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀');
      _logger.log(Level.info, logs);
      _logger.log(Level.info,
          '🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀');
    }
  }
}
