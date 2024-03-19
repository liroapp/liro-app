import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static final SharedPref _instance = SharedPref._();
  static SharedPref get instance => _instance;

  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String userPhone = 'userPhone';
  static const String userEmail = 'userEmail';
  static const String accessToken = 'accessToken';
  static const String refreshToekn = 'refreshToken';

  late SharedPreferences sharedPref;
  initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  //Get User
  Future<String?> getUser() async {
    final user = sharedPref.getString(userPhone);
    return user;
  }
  //Get User Email
  Future<String?> getUserEmail() async {
    final useremail = sharedPref.getString(userEmail);
    return useremail;
  }

  //Get User Email
  Future<String?> getUserName() async {
    final username = sharedPref.getString(userName);
    return username;
  }

  // SharedPref class
  Future<String?> getUserId() async {
    final storedUserId = sharedPref.getString(userId); // Change the variable name
    return storedUserId;
  }

   Future<String?> getAccessToken() async {
    final storedAccessToken = sharedPref.getString(accessToken); // Change the variable name
    return storedAccessToken;
  }

  Future<String?> getRefreshToken() async {
    final storedRefreshToken = sharedPref.getString(refreshToekn); // Change the variable name
    return storedRefreshToken;
  }
}
