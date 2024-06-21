import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../repository/user_repository/src/user_repository.dart';
import '../utilities/constants.dart';

class UserProvider with ChangeNotifier{


  Status _status = Status.init;

  Status get status => _status;
  String errorMessage = 'cxvxcvx';

  final UserRepository _userRepository = UserRepository();

  Future<void> register({required String username, required String password, required String email}) async {
    _status = Status.loading;
    notifyListeners();
    try {

      final response =await _userRepository.register(username: username, password: password,email: email);
      log("status code${response.statusCode}");

      if(response.statusCode ==201){
        _status = Status.success;
      }else{

        _status = Status.error;
        errorMessage = "Unauthorized";
        log("status ${status}");
      }

    } catch (e) {
      log("error ${e}");
    //  _status = Status.error;
     // errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }


}