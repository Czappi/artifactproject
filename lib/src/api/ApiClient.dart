import 'dart:io';

import 'package:artifactproject/src/api/ApiResponse.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client = Client();

  Future<Cookie?> post(String url, Cookie cookie) async {
    var response = await _client.get(Uri.parse(url),
        headers: {HttpHeaders.cookieHeader: _cookieToHeader(cookie)});

    Cookie ciSession = cookie;
    if (response.headers.containsKey("set-cookie")) {
      ciSession = Cookie.fromSetCookieValue(response.headers["set-cookie"]!);
    }

    return ciSession;
  }

  Future<ApiResponse> get(String url,
      {Cookie? cookie, String? referrer}) async {
    var response = await _client.get(Uri.parse(url),
        headers: (cookie != null)
            ? {HttpHeaders.cookieHeader: _cookieToHeader(cookie)}
            : {});

    Cookie? ciSession = cookie;
    if (response.headers.containsKey("set-cookie")) {
      ciSession = Cookie.fromSetCookieValue(response.headers["set-cookie"]!);
    }

    return ApiResponse(ciSession, response.body);
  }

  Future<String?> getLocation(String url, Cookie cookie,
      {String? referrer}) async {
    var response = await _client.get(Uri.parse(url),
        headers: {HttpHeaders.cookieHeader: _cookieToHeader(cookie)});

    return response.headers["location"];
  }

  String _cookieToHeader(Cookie cookie) {
    return "${cookie.name}=${cookie.value}";
  }
}
