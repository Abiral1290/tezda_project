import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../../../api_request/http_requests.dart';

class UserApiServies{

  Future<Response> registerUser({required String username,
    required String password, required String email,
    }) async {
    Map<String, dynamic> registerCredentials = <String, dynamic>{};
    registerCredentials['name'] = username;
    registerCredentials['password'] = password;
    registerCredentials['email'] = email;
    registerCredentials['avatar'] = "https://picsum.photos/800";
    log("This is registerCredentials $registerCredentials");
    final response = await HttpRequests.requestPost('/api/v1/users/', registerCredentials);
    log("This is response ${response.body}");
    return response;
  }

  Future<Response> loginUser({
    required String password, required String email,
  }) async {
    Map<String, dynamic> loginCredentials = <String, dynamic>{};

    loginCredentials['password'] = password;
    loginCredentials['email'] = email;
    log("This is registerCredentials $loginCredentials");
    final response = await HttpRequests.requestPost('/api/v1/auth/login', loginCredentials);
    log("This is response ${response.body}");
    return response;
  }


}