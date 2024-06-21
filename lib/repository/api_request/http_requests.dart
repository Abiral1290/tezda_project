import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/preference_controller.dart';
import '../../utilities/constants.dart';
import 'exception.dart';


class HttpRequests {


  static const String urlbase = "api.escuelajs.co";
  static const bool localServer = false;

  static final Connectivity _connectivity = Connectivity();

  static Future<Map<String, String>> createHeaders([requiresHeader = true, isContent = true]) async {
    Map<String, String> headers = <String, String>{};
    if (isContent) {
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
      headers['Content-Type'] = 'application/json; charset=UTF-8';
      headers['Accept'] = 'application/json';
    }

    return headers;
  }

  static Future<http.Response> requestGet(String api, {Map<String, dynamic>? query, requiresHeader = true}) async {
    List<ConnectivityResult> connection = await _connectivity.checkConnectivity();
    if (connection != ConnectivityResult.none) {
      try {
        log(query.toString());
        final Uri url;
       // if (localServer) {
          url = Uri.http(urlbase, api, query);


        final headers = await createHeaders(requiresHeader);
        log(url.toString(), name: 'Get request send', zone: Zone.current);

        final resp = await http.get(url, headers: headers).timeout(const Duration(seconds: 60), onTimeout: () {
          throw TimeoutException('The connection has timed out, Please try again!');
        });

        debugPrint('------------------ API Response Start ----------------------');
        log(resp.body, name: url.toString(), zone: Zone.current);
        return responseErrorChecker(resp);
      } on SocketException {
        throw NetworkConnectionError();
      } on HandleUncaughtErrorHandler {
        log(name: 'uncaught error', 'Error', stackTrace: StackTrace.current);
        throw 'Unhandled error occured';
      }
    } else {
      throw NetworkConnectionError;
    }
  }

  static Future<http.Response> requestPost(String api, dynamic body, [requiresHeader = true]) async {
    List<ConnectivityResult> connection = await _connectivity.checkConnectivity() ;
    log("connection $connection");
    if (connection != ConnectivityResult.none) {
      try {
        final Uri url;
         log("urlbase $urlbase");
          url = Uri.http(urlbase, api);
          log("url $url");


        var headers = await createHeaders(requiresHeader);
        log('------------------ API Request Start ----------------------');
        log("POST: $url");
        log("Headers: $headers");
        log("Parameters: $body");
        log('------------------ API Request End ----------------------');
        var resp = await http
            .post(

          url,
          body: jsonEncode(body),
          headers: headers,
        )
            .timeout(const Duration(seconds: 60), onTimeout: () {
          throw TimeoutException('The connection has timed out, Please try again!');
        });
        log('------------------ API Response Start ----------------------');
        log('$url');
        log('Response: ${resp.body}');
        log('------------------- API Response End ----------------------');
        return resp;
      } on SocketException {
        throw NetworkConnectionError();
      } on HandleUncaughtErrorHandler {
        throw 'Unhandled error occured';
      }
    } else {
      log('fef');
      throw NetworkConnectionError();
    }
  }

  static Future<http.Response> requestPut(String api, dynamic body, [requiresHeader = true]) async {
    try {
      final Uri url;
      if (localServer) {
        url = Uri.http(urlbase, api);
      } else {
        url = Uri.https(urlbase, api);
      }
      Map<String, String> headers = await createHeaders(requiresHeader);
      log('------------------ API Request Start ----------------------');
      log("POST: $url");
      log("Headers: $headers");
      log("Parameters: $body");
      log('------------------ API Request End ----------------------');
      var resp = await http
          .put(
        url,
        body: jsonEncode(body),
        headers: headers,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException('The connection has timed out, Please try again!');
      });
      log('------------------ API Response Start ----------------------');
      log('$url');
      log('Response: ${resp.body}');
      log('------------------- API Response End ----------------------');
      return resp;
    } on SocketException {
      throw NetworkConnectionError();
    } on HandleUncaughtErrorHandler {
      throw 'Unhandled error occured';
    }
  }

  static http.Response responseErrorChecker(http.Response resp) {
    if (resp.statusCode == 400) throw BadRequestError();
    if (resp.statusCode == 403) throw ForbiddenError();
    if (resp.statusCode == 404) throw NotFoundError();
    if (resp.statusCode >= 500) throw InternalServerError();
    return resp;
  }
}

