import 'dart:convert';
import 'dart:io';

import 'package:artifactproject/src/api/ApiResponse.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client = Client();
  Cookie ciSession = Cookie('ciSession', '');

  Future<ApiResponse> post(String url,
      {String? body, Encoding? encoding}) async {
    var response = await _client.post(
      Uri.parse(url),
      headers: {HttpHeaders.cookieHeader: _cookieToHeader(ciSession)},
      body: body,
      encoding: encoding,
    );

    var isUpdated = updateSession(response);
    return ApiResponse(ciSession, isUpdated, response.body);
  }

  Future<ApiResponse> get(String url,
      {Cookie? cookie, String? referrer}) async {
    var response = await _client.get(Uri.parse(url),
        headers: (cookie != null)
            ? {HttpHeaders.cookieHeader: _cookieToHeader(cookie)}
            : {});

    var isUpdated = updateSession(response);
    return ApiResponse(ciSession, isUpdated, response.body);
  }

  String _cookieToHeader(Cookie cookie) {
    return "${cookie.name}=${cookie.value}";
  }

  bool updateSession(Response response) {
    if (response.headers.containsKey("set-cookie")) {
      ciSession = Cookie.fromSetCookieValue(response.headers["set-cookie"]!);
      return true;
    } else {
      return false;
    }
  }
}
