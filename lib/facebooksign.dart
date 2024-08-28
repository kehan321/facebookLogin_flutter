import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInController with ChangeNotifier {
  Map<String, dynamic>? userData;

  Future<void> login() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.instance.getUserData(
        fields: 'email,name,picture',
      );
      userData = requestData;
      notifyListeners();
    } else {
      print(result.message); // Check for any error messages
    }
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    userData = null;
    notifyListeners();
  }
}
