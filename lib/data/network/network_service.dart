import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:plj_absensi_mobile/data/local/session.dart';
import 'package:get/get.dart';
import 'package:plj_absensi_mobile/routes/route_names.dart';

import 'custom_exception.dart';

class NetworkService {
  static dynamic compileResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(generateError(response.body));
      case 401:
        Session.clearSession();
        Get.offAllNamed(RouteNames.signInScreen);
        throw UnauthorisedException(generateError(response.body));
      case 402:
        throw UnauthorisedException(generateError(response.body));
      case 403:
        throw UnauthorisedException(generateError(response.body));
      case 409:
        throw ConflictException(generateError(response.body));
      case 404:
        throw NotFoundException(generateError(response.body));
      case 500:
        throw InternalServerErrorException(generateError(response.body));

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  static dynamic generateError(String responseBody) {
    Map<String, dynamic> errorBody = json.decode(responseBody);
    if (errorBody.containsKey('failed')) {
      return errorBody['failed'];
    }

    if (errorBody.containsKey('error')) {
      return errorBody['error'];
    }

    if (errorBody.containsKey('message')) {
      return errorBody['message'];
    }

    final errorKeys = errorBody.keys.toList();

    if (errorKeys.isNotEmpty) {
      return errorBody[errorKeys[0]][0];
    }

    return errorBody['message'];
  }

  // static String getImageUrl(String baseUrl, String imageUrl,
  //     [bool isHttps = true]) {
  //   return isHttps
  //       ? Uri.https(baseUrl, '${ApiEndpoints.assetsPrefix}/$imageUrl').toString()
  //       : Uri.http(baseUrl, '${ApiEndpoints.assetsPrefix}/$imageUrl').toString();
  // }

  static Future<dynamic> get(
    String baseUrl,
    String url,
    Map<String, String> headers,
    Map<String, String>? queryParameters, {
    bool withToken = false,
    bool isHttps = false,
  }) async {
    final uri = isHttps
        ? Uri.https(baseUrl, url, queryParameters)
        : Uri.http(baseUrl, url, queryParameters);

    try {
      if (withToken) {
        final token = await Session.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      headers.addAll({'Accept': 'application/json'});

      log('GET: ${uri.toString()}');
      log('PARAMS: ${queryParameters.toString()}');
      log('HEADERS: ${headers.toString()}');

      final response = await http.get(uri, headers: headers);

      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on FormatException {
      throw const FormatException('unauthorized');
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> post(
    String baseUrl,
    String url,
    Map<String, String> headers,
    Map<String, String> data, {
    bool withToken = false,
    bool isHttps = false,
  }) async {
    var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);

    try {
      headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await Session.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      log('POST: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${data.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');

      final response = await http.post(uri, body: data, headers: headers);
      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on NotFoundException {
      throw NotFoundException('Akun tidak terdaftar');
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> put(
    String baseUrl,
    String url,
    Map<String, String> data, {
    bool withToken = false,
    bool isHttps = false,
    Map<String, String> headers = const {},
  }) async {
    var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);

    try {
      headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await Session.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      log('PUT: ${uri.toString()}', name: 'NETWORK SERVICE');
      log('PARAMS: ${data.toString()}', name: 'NETWORK SERVICE');
      log('HEADERS: ${headers.toString()}', name: 'NETWORK SERVICE');

      final response = await http.put(uri, body: data, headers: headers);
      return compileResponse(response);
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    } on NotFoundException {
      throw NotFoundException('Akun tidak terdaftar');
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> postWithImage(
    String baseUrl,
    String url,
    Map<String, String> data,
    File picture,
    String name, {
    bool isHttps = false,
    bool withToken = true,
    bool isResponseJson = true,
    required Map<String, String> headers,
  }) async {
    try {
      var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);

      log(uri.toString(), name: 'POST WITH IMAGES');
      log(data.toString(), name: 'POST WITH IMAGES');

      var request = http.MultipartRequest('POST', uri);

      Map<String, String> contentType = {"Content-type": "multipart/form-data"};

      request.files.add(
        http.MultipartFile(
          name,
          picture.readAsBytes().asStream(),
          picture.lengthSync(),
          filename: '$name.jpeg',
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
      );

      request.headers.addAll(contentType);

      request.headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await Session.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      request.headers.addAll(headers);
      log(request.headers.toString(), name: 'POST WITH IMAGES');
      log(request.files[0].field.toString(), name: 'POST WITH IMAGES');

      request.fields.addAll(data);

      var res = await request.send();
      final response = await http.Response.fromStream(res);

      if (isResponseJson) {
        return compileResponse(response);
      }
      return response;
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    }
  }

  static Future<dynamic> putWithImage(
    String baseUrl,
    String url,
    Map<String, String> data,
    File picture,
    String name, {
    bool isHttps = false,
    bool withToken = true,
    bool isResponseJson = true,
    required Map<String, String> headers,
  }) async {
    try {
      var uri = isHttps ? Uri.https(baseUrl, url) : Uri.http(baseUrl, url);

      log(uri.toString(), name: 'PUT WITH IMAGES');
      log(data.toString(), name: 'PUT WITH IMAGES');

      var request = http.MultipartRequest('PUT', uri);

      Map<String, String> contentType = {"Content-type": "multipart/form-data"};

      request.files.add(
        http.MultipartFile(
          name,
          picture.readAsBytes().asStream(),
          picture.lengthSync(),
          filename: '$name.jpeg',
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ),
      );

      request.headers.addAll(contentType);

      request.headers.addAll({'Accept': 'application/json'});
      if (withToken) {
        final token = await Session.getBearerToken();
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      request.headers.addAll(headers);
      log(request.headers.toString(), name: 'PUT WITH IMAGES');
      log(request.files[0].field.toString(), name: 'PUT WITH IMAGES');

      request.fields.addAll(data);

      var res = await request.send();
      final response = await http.Response.fromStream(res);

      if (isResponseJson) {
        return compileResponse(response);
      }
      return response;
    } on SocketException {
      throw FetchDataException('Tidak ada koneksi internet');
    }
  }
}
