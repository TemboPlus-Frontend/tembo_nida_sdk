import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' show debugPrint;
import 'package:uuid/uuid.dart';

const rootURL = "https://gateway.temboplus.com";

var _token =
    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJvbmJvYXJkIiwicm9sZXMiOlsib25ib2FyZCJdLCJleHAiOjE3MDc0MDgyMTN9.BuGnAdoWyhYjyy-m3WGQzj-roUtDn-Tfx3U4ZWhifpVmAJmxbz2dU6YFkgi9XozflnUA-qHpZoY-48Qxnf5V7aHAyYEyW25W1leugwjkN9dlmfte4wKE9VKqXndtX1OEgmTZJDZhf3LDGpdgC9kKcW521W52w63-meR-ITC0dx8vlxXytL2VsFCqiByt2iTJU6gWHriIuVZm08eYVCf4igwkDC8xW9aduCNZ1yfQMS3cvdxCkClczZhgw1ZXR1HXwSnmjo1N1BRwJXC3lEPmbou5rF0QmBzVh_64gmiMg5svjwHaachGxA4W9yTBQlSbJMgzwa4uPFshJOAqBkR1SQ";

typedef StatusCodeHandler = void Function(int statusCode);

abstract class BaseHTTPAPI {
  final String? mainEndpoint;
  BaseHTTPAPI([this.mainEndpoint]);

  String get url => mainEndpoint == null ? rootURL : "$rootURL/$mainEndpoint";

  Uri getUri(String endpoint) {
    print(url);
    print(endpoint);
    if (endpoint.trim().isEmpty) return Uri.parse(url);
    return Uri.parse("$url/$endpoint");
  }

  Map<String, String> get _headers => {
        "content-type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      };

  Map<String, String> get headers {
    if (_token.isEmpty) return _headers;

    final uuid = const Uuid().v1();
    _headers.update("x-request-id", (_) => uuid, ifAbsent: () => uuid);
    return _headers..addAll({"x-authorization": _token});
  }

  Future<T> get<T>(
    String endpoint, {
    String? params,
    StatusCodeHandler? statusCodeHandler,
  }) async {
    var url = getUri(endpoint);
    if (params?.trim().isNotEmpty ?? false) {
      url = url.updateQueryParameters(params!);
    }
    final response = await http.get(url, headers: headers);
    return getResult(response, null, statusCodeHandler);
  }

  Future<T> post<T>(
    String endpoint, {
    String? body,
    StatusCodeHandler? statusCodeHandler,
    String? params,
  }) async {
    var url = getUri(endpoint);
    if (params?.trim().isNotEmpty ?? false) {
      url = url.updateQueryParameters(params!);
    }
    final response = await http.post(
      url,
      body: body,
      headers: headers,
    );
    return getResult(response, body, statusCodeHandler);
  }

  Future<T> patch<T>(
    String endpoint,
    String body, [
    StatusCodeHandler? statusCodeHandler,
  ]) async {
    final response = await http.patch(
      getUri(endpoint),
      body: body,
      headers: headers,
    );
    return getResult(response, body, statusCodeHandler);
  }

  dynamic getResult(
    http.Response response, [
    dynamic requestBody,
    StatusCodeHandler? statusCodeHandler,
  ]) {
    debugPrint(response.stringRep(requestBody));

    if (statusCodeHandler != null) statusCodeHandler(response.statusCode);

    final body = jsonDecode(response.body);
    if (body is Map) return body;
    if (body is List) return List<Map<String, dynamic>>.from(body);
    return body;
  }
}

extension ResponseExtension on http.Response {
  String stringRep([dynamic requestBody]) {
    return """
    Request:
      url: ${request?.url}
      method: ${request?.method}
      token: ${request?.headers['x-authorization']}
      body: $requestBody

    Response:
      statusCode: $statusCode
      body: $body
""";
  }
}

class AppHTTPOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

extension on Uri {
  Uri updateQueryParameters(String query) {
    return Uri(
      host: host,
      scheme: scheme,
      port: port,
      userInfo: userInfo,
      path: path,
      pathSegments: null,
      fragment: fragment,
      query: query,
      queryParameters: null,
    );
  }
}
