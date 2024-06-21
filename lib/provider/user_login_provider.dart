import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../repository/user_repository/src/user_repository.dart';
import '../utilities/constants.dart';

class UserLoginProvider with ChangeNotifier{

  Status _status = Status.init;

  Status get status => _status;
  String errorMessage = '';

  final UserRepository _userRepository = UserRepository();

  Future<void> login({ required String password, required String email}) async {

     _status = Status.loading;
    notifyListeners();
    try {

      final response =await _userRepository.login(password: password,email: email);
      log("response ${password}");
      if(response.statusCode ==201){
        _status = Status.success;
      }else{

        _status = Status.error;
        errorMessage = "Unauthorized";
      }

     // log("status ${status}");
      // isJobseekerLoggedIn.value = true;

      log("status ${status}");

    } catch (e) {
      errorMessage =e.toString();
      log("errorsss ${e}");
      //  _status = Status.error;
      // errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }


}