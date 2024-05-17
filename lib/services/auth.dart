

import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
 bool _isLoggedIn = false;

 bool get authentcated => _isLoggedIn;

 void login(Map creds) {
   _isLoggedIn = true;

   notifyListeners();
 }

 void logout() {
   _isLoggedIn = false;

   notifyListeners();
 }

}