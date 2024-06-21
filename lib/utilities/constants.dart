// ignore_for_file: non_constant_identifier_names



enum Status { init, loading, success, error }

class Constants {
  ///shared preferences keys
  static const String userLoggedIn = 'isUsedLoggedIn';
  static const String userToken = 'userToken';
  static const String rememberMe = 'rememberMe';


  static String otp = '';
  static String phoneNumber = '';
  static String email = '';
  static bool isLoading = false;
  static List JobInfoslug = [];
  static String jobDetailslug = '';
  static String jobDetailLocation = '';
  static var nexpageUri = '';
  static String jobsallcategoryslug = '';
  static String jobslugtoApply = '';
  static String likeJobsprofileid = '';
  static int provinceId = 0;
  static int districtId = 0;
  static int citiesId = 0;
  static int categoryNested = 0;

  static List listofCategory = [];
  static bool searchAndFilter = false;


  static String JobseekerBasicId = '';
  static String Api_Token = '';

}

