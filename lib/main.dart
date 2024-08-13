import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FacebookSignInController(),
      child: MaterialApp(
        title: 'Facebook Sign-In App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return AdminScreen();
              } else {
                return LoginPage1();
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Admin Screen")),
    );
  }
}

class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: LoginUI(),
    );
  }

  Widget LoginUI() {
    return Consumer<FacebookSignInController>(builder: (context, model, child) {
      if (model.userData != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return loginController(context);
      }
    });
  }

  Widget loggedInUI(FacebookSignInController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.userData!['picture']['data']['url'] ?? "").image,
          radius: 50,
        ),
        Text(model.userData!['name'] ?? ""),
        Text(model.userData!['email'] ?? ""),
        ActionChip(
          label: Text("Logout"),
          avatar: Icon(Icons.logout),
          onPressed: () {
            Provider.of<FacebookSignInController>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Widget loginController(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 80,
            width: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Log in to see more',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 110,
          ),
          GestureDetector(
            child: Image.asset(
              "assets/facebook.png",
              width: 240,
            ),
            onTap: () {
              Provider.of<FacebookSignInController>(context, listen: false).login();
            },
          ),
        ],
      ),
    );
  }
}

class FacebookSignInController with ChangeNotifier {
  Map<String, dynamic>? userData;

  login() async {
    var result = await FacebookAuth.instance.login(
      permissions: ["public_profile", "email"],
    );
    if (result.status == LoginStatus.success) {
      final requestData =
          await FacebookAuth.instance.getUserData(fields: "email,name,picture");
      userData = requestData;
      notifyListeners();
    }
  }

  logout() async {
    await FacebookAuth.instance.logOut();
    userData = null;
    notifyListeners();
  }
}





// // import 'package:flutter/material.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:provider/provider.dart';

// // class LoginPage1 extends StatefulWidget {
// //   const LoginPage1({super.key});

// //   @override
// //   State<LoginPage1> createState() => _LoginPage1State();
// // }

// // class _LoginPage1State extends State<LoginPage1> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.blue,
// //       body: LoginUI(),
// //     );
// //   }

// //   Widget LoginUI() {
// //     return Consumer<LoginController>(builder: (context, model, child) {
// //       if (model.userDetails != null) {
// //         return Center(
// //           child: loggedInUI(model),
// //         );
// //       } else {
// //         return loginController(context);
// //       }
// //     });
// //   }

// //   Widget loggedInUI(LoginController model) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         CircleAvatar(
// //           backgroundImage:
// //               Image.network(model.userDetails!.photoURL ?? "").image,
// //           radius: 50,
// //         ),
// //         Text(model.userDetails!.displayName ?? ""),
// //         Text(model.userDetails!.email ?? ""),
// //         ActionChip(
// //           label: Text("Logout"),
// //           avatar: Icon(Icons.logout),
// //           onPressed: () {
// //             Provider.of<LoginController>(context, listen: false).logout();
// //           },
// //         )
// //       ],
// //     );
// //   }

// //   Widget loginController(BuildContext context) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Image.asset(
// //             "assets/logo.png",
// //             height: 80,
// //             width: 100,
// //           ),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Text(
// //             'Log in to see more ',
// //             style: TextStyle(
// //               fontSize: 20,
// //             ),
// //           ),
// //           SizedBox(
// //             height: 110,
// //           ),
// //           GestureDetector(
// //             child: Image.asset(
// //               "assets/google.png",
// //               width: 240,
// //             ),
// //             onTap: () {
// //               Provider.of<LoginController>(context, listen: false)
// //                   .googleLogin();
// //             },
// //           ),
// //           SizedBox(
// //             height: 110,
// //           ),
// //           GestureDetector(
// //             child: Image.asset(
// //               "assets/facebook.png", // Ensure this asset exists
// //               width: 240,
// //             ),
// //             onTap: () {
// //               Provider.of<LoginController>(context, listen: false)
// //                   .facebookLogin();
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class FacebookSignInController with ChangeNotifier {
// //   Map? userData;
  
// //   login() async {
// //     var result = await FacebookAuth.i.login(
// //       permissions: ["public_profile", "email"],
// //     );
// //     if (result.status == LoginStatus.success) {
// //       final requestData = await FacebookAuth.i.getUserData(fields: "email, name, picture");
// //       userData = requestData;
// //       notifyListeners();
// //     }
// //   }

// //   logout() async {
// //     await FacebookAuth.i.logOut();
// //     userData = null;
// //     notifyListeners();
// //   }
// // }

// // class GoogleSignInController with ChangeNotifier {
// //   var _googleSignIn = GoogleSignIn();
// //   GoogleSignInAccount? googleSignInAccount;

// //   login() async {
// //     this.googleSignInAccount = await _googleSignIn.signIn();
// //     notifyListeners();
// //   }

// //   logout() async {
// //     await _googleSignIn.signOut();
// //     googleSignInAccount = null;
// //     notifyListeners();
// //   }
// // }

// // class LoginController with ChangeNotifier {
// //   var _googleSignIn = GoogleSignIn();
// //   GoogleSignInAccount? googleSignInAccount;
// //   UserDetails? userDetails;

// //   googleLogin() async {
// //     this.googleSignInAccount = await _googleSignIn.signIn();
// //     this.userDetails = UserDetails(
// //       displayName: this.googleSignInAccount!.displayName,
// //       email: this.googleSignInAccount!.email,
// //       photoURL: this.googleSignInAccount!.photoUrl,
// //     );
// //     notifyListeners();
// //   }

// //   facebookLogin() async {
// //     var result = await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
// //     if (result.status == LoginStatus.success) {
// //       final requestData = await FacebookAuth.i.getUserData(fields: "email, name, picture");
// //       this.userDetails = UserDetails(
// //         displayName: requestData["name"],
// //         email: requestData["email"],
// //         photoURL: requestData["picture"]["data"]["url"] ?? "",
// //       );
// //       notifyListeners();
// //     }
// //   }

// //   logout() async {
// //     await _googleSignIn.signOut();
// //     userDetails = null;
// //     notifyListeners();
// //   }
// // }

// // class UserDetails {
// //   final String? displayName;
// //   final String? email;
// //   final String? photoURL;

// //   UserDetails({this.displayName, this.email, this.photoURL});
// // }

// // // Main function and MyApp remain the same as in your original code









 // Import the HomePage

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//         final User? user = userCredential.user;

//         if (user != null) {
//           // Navigate to the HomePage
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => AdminScreen()),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error during Google Sign-In: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Sign-In'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _signInWithGoogle,
//           child: Text('Sign In with Google'),
//         ),
//       ),
//     );
//   }
// }
