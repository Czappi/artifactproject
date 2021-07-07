import 'dart:convert';
import 'dart:io';

import 'package:artifactproject/src/api/ApiResponse.dart';
import 'package:http/http.dart';

enum PageSession { mainpage, readpage }

class ApiClient {
  final Client _client = Client();
  Cookie mainpageSession = Cookie('ciSession', '');
  Cookie readpageSession = Cookie('ciSession', '');

  Future<ApiResponse> post(
    String url, {
    String? body,
    Encoding? encoding,
    PageSession pageSession = PageSession.mainpage,
  }) async {
    var response = await _client.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.cookieHeader: _cookieToHeader(_cookieChoose(pageSession))
      },
      body: body,
      encoding: encoding,
    );

    var isUpdated = updateSession(response, pageSession);
    return ApiResponse(_cookieChoose(pageSession), isUpdated, response.body);
  }

  Future<ApiResponse> get(
    String url, {
    Cookie? cookie,
    String? referrer,
    PageSession pageSession = PageSession.mainpage,
  }) async {
    var response = await _client.get(Uri.parse(url),
        headers: (cookie != null)
            ? {
                HttpHeaders.cookieHeader:
                    _cookieToHeader(_cookieChoose(pageSession))
              }
            : {});

    var isUpdated = updateSession(response, pageSession);
    return ApiResponse(_cookieChoose(pageSession), isUpdated, response.body);
  }

  String _cookieToHeader(Cookie cookie) {
    return "${cookie.name}=${cookie.value}";
  }

  Cookie _cookieChoose(PageSession session) {
    return session == PageSession.mainpage ? mainpageSession : readpageSession;
  }

  bool updateSession(Response response, PageSession session) {
    if (response.headers.containsKey("set-cookie")) {
      if (session == PageSession.mainpage) {
        mainpageSession =
            Cookie.fromSetCookieValue(response.headers["set-cookie"]!);
      }
      if (session == PageSession.readpage) {
        readpageSession =
            Cookie.fromSetCookieValue(response.headers["set-cookie"]!);
      }

      return true;
    } else {
      return false;
    }
  }
}
