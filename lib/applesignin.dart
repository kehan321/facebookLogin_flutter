import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInWithAppleButton(
        onPressed: () async {
          try {
            final credential = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
            );

            // Handle credential and sign in
            print('Apple ID Token: ${credential.identityToken}');
            print('Email: ${credential.email}');
            print('Name: ${credential.givenName} ${credential.familyName}');
            
            // You can use these details to sign in or register the user in your backend
            
          } catch (e) {
            print('Error during Apple sign-in: $e');
          }
        },
      ),
    );
  }
}
