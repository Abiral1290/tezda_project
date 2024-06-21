import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart';
import 'package:tezda_projects/repository/user_repository/src/user_api_servies/user_api_servies.dart';

import '../../../controller/preference_controller.dart';
import '../../../utilities/constants.dart';

class UserRepository{

  final UserApiServies _userApiServies;

  UserRepository({UserApiServies? userApiServies}):_userApiServies = userApiServies ?? UserApiServies();


  Future<Response> register({required String username, required String password,required String email}) async {
    final response = await _userApiServies.registerUser(
        username: username, password: password,email: email);

   // final token = json.decode(response.body);
    log("status ${response.statusCode}");



    return response;
  }


  Future<Response> login({required String password,required String email}) async {
    final response = await _userApiServies.loginUser(
         password: password,email: email);
    log("status code ${response.statusCode}");
  if(response.statusCode ==201){
      final token = json.decode(response.body)["access_token"];

      await PreferenceController.sharedPreferences.setString(Constants.userToken, token).then((value) {
        PreferenceController.sharedPreferences.setBool(Constants.userLoggedIn, true);
      });
      return response;
     }
  return response;
  }


}