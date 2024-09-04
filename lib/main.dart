// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => FacebookSignInController(),
//       child: MaterialApp(
//         title: 'Facebook Sign-In App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.active) {
//               if (snapshot.hasData) {
//                 return AdminScreen();
//               } else {
//                 return LoginPage1();
//               }
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }

// class AdminScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("Admin Screen")),
//     );
//   }
// }

// class LoginPage1 extends StatefulWidget {
//   @override
//   _LoginPage1State createState() => _LoginPage1State();
// }

// class _LoginPage1State extends State<LoginPage1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: LoginUI(),
//     );
//   }

//   Widget LoginUI() {
//     return Consumer<FacebookSignInController>(builder: (context, model, child) {
//       if (model.userData != null) {
//         return Center(
//           child: loggedInUI(model),
//         );
//       } else {
//         return loginController(context);
//       }
//     });
//   }

//   Widget loggedInUI(FacebookSignInController model) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundImage: Image.network(model.userData!['picture']['data']['url'] ?? "").image,
//           radius: 50,
//         ),
//         Text(model.userData!['name'] ?? ""),
//         Text(model.userData!['email'] ?? ""),
//         ActionChip(
//           label: Text("Logout"),
//           avatar: Icon(Icons.logout),
//           onPressed: () {
//             Provider.of<FacebookSignInController>(context, listen: false).logout();
//           },
//         )
//       ],
//     );
//   }

//   Widget loginController(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             "assets/logo.png",
//             height: 80,
//             width: 100,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'Log in to see more',
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//           SizedBox(
//             height: 110,
//           ),
//           GestureDetector(
//             child: Image.asset(
//               "assets/facebook.png",
//               width: 240,
//             ),
//             onTap: () {
//               Provider.of<FacebookSignInController>(context, listen: false).login();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FacebookSignInController with ChangeNotifier {
//   Map<String, dynamic>? userData;

//   login() async {
//     var result = await FacebookAuth.instance.login(
//       permissions: ["public_profile", "email"],
//     );
//     if (result.status == LoginStatus.success) {
//       final requestData =
//           await FacebookAuth.instance.getUserData(fields: "email,name,picture");
//       userData = requestData;
//       notifyListeners();
//     }
//   }

//   logout() async {
//     await FacebookAuth.instance.logOut();
//     userData = null;
//     notifyListeners();
//   }
// }





// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// // // import 'package:google_sign_in/google_sign_in.dart';
// // // import 'package:provider/provider.dart';

// // // class LoginPage1 extends StatefulWidget {
// // //   const LoginPage1({super.key});

// // //   @override
// // //   State<LoginPage1> createState() => _LoginPage1State();
// // // }

// // // class _LoginPage1State extends State<LoginPage1> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.blue,
// // //       body: LoginUI(),
// // //     );
// // //   }

// // //   Widget LoginUI() {
// // //     return Consumer<LoginController>(builder: (context, model, child) {
// // //       if (model.userDetails != null) {
// // //         return Center(
// // //           child: loggedInUI(model),
// // //         );
// // //       } else {
// // //         return loginController(context);
// // //       }
// // //     });
// // //   }

// // //   Widget loggedInUI(LoginController model) {
// // //     return Column(
// // //       mainAxisAlignment: MainAxisAlignment.center,
// // //       crossAxisAlignment: CrossAxisAlignment.center,
// // //       children: [
// // //         CircleAvatar(
// // //           backgroundImage:
// // //               Image.network(model.userDetails!.photoURL ?? "").image,
// // //           radius: 50,
// // //         ),
// // //         Text(model.userDetails!.displayName ?? ""),
// // //         Text(model.userDetails!.email ?? ""),
// // //         ActionChip(
// // //           label: Text("Logout"),
// // //           avatar: Icon(Icons.logout),
// // //           onPressed: () {
// // //             Provider.of<LoginController>(context, listen: false).logout();
// // //           },
// // //         )
// // //       ],
// // //     );
// // //   }

// // //   Widget loginController(BuildContext context) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Image.asset(
// // //             "assets/logo.png",
// // //             height: 80,
// // //             width: 100,
// // //           ),
// // //           SizedBox(
// // //             height: 10,
// // //           ),
// // //           Text(
// // //             'Log in to see more ',
// // //             style: TextStyle(
// // //               fontSize: 20,
// // //             ),
// // //           ),
// // //           SizedBox(
// // //             height: 110,
// // //           ),
// // //           GestureDetector(
// // //             child: Image.asset(
// // //               "assets/google.png",
// // //               width: 240,
// // //             ),
// // //             onTap: () {
// // //               Provider.of<LoginController>(context, listen: false)
// // //                   .googleLogin();
// // //             },
// // //           ),
// // //           SizedBox(
// // //             height: 110,
// // //           ),
// // //           GestureDetector(
// // //             child: Image.asset(
// // //               "assets/facebook.png", // Ensure this asset exists
// // //               width: 240,
// // //             ),
// // //             onTap: () {
// // //               Provider.of<LoginController>(context, listen: false)
// // //                   .facebookLogin();
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class FacebookSignInController with ChangeNotifier {
// // //   Map? userData;
  
// // //   login() async {
// // //     var result = await FacebookAuth.i.login(
// // //       permissions: ["public_profile", "email"],
// // //     );
// // //     if (result.status == LoginStatus.success) {
// // //       final requestData = await FacebookAuth.i.getUserData(fields: "email, name, picture");
// // //       userData = requestData;
// // //       notifyListeners();
// // //     }
// // //   }

// // //   logout() async {
// // //     await FacebookAuth.i.logOut();
// // //     userData = null;
// // //     notifyListeners();
// // //   }
// // // }

// // // class GoogleSignInController with ChangeNotifier {
// // //   var _googleSignIn = GoogleSignIn();
// // //   GoogleSignInAccount? googleSignInAccount;

// // //   login() async {
// // //     this.googleSignInAccount = await _googleSignIn.signIn();
// // //     notifyListeners();
// // //   }

// // //   logout() async {
// // //     await _googleSignIn.signOut();
// // //     googleSignInAccount = null;
// // //     notifyListeners();
// // //   }
// // // }

// // // class LoginController with ChangeNotifier {
// // //   var _googleSignIn = GoogleSignIn();
// // //   GoogleSignInAccount? googleSignInAccount;
// // //   UserDetails? userDetails;

// // //   googleLogin() async {
// // //     this.googleSignInAccount = await _googleSignIn.signIn();
// // //     this.userDetails = UserDetails(
// // //       displayName: this.googleSignInAccount!.displayName,
// // //       email: this.googleSignInAccount!.email,
// // //       photoURL: this.googleSignInAccount!.photoUrl,
// // //     );
// // //     notifyListeners();
// // //   }

// // //   facebookLogin() async {
// // //     var result = await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
// // //     if (result.status == LoginStatus.success) {
// // //       final requestData = await FacebookAuth.i.getUserData(fields: "email, name, picture");
// // //       this.userDetails = UserDetails(
// // //         displayName: requestData["name"],
// // //         email: requestData["email"],
// // //         photoURL: requestData["picture"]["data"]["url"] ?? "",
// // //       );
// // //       notifyListeners();
// // //     }
// // //   }

// // //   logout() async {
// // //     await _googleSignIn.signOut();
// // //     userDetails = null;
// // //     notifyListeners();
// // //   }
// // // }

// // // class UserDetails {
// // //   final String? displayName;
// // //   final String? email;
// // //   final String? photoURL;

// // //   UserDetails({this.displayName, this.email, this.photoURL});
// // // }

// // // // Main function and MyApp remain the same as in your original code









//  // Import the HomePage

// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final GoogleSignIn _googleSignIn = GoogleSignIn();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   Future<void> _signInWithGoogle() async {
// //     try {
// //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
// //       if (googleUser != null) {
// //         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

// //         final AuthCredential credential = GoogleAuthProvider.credential(
// //           accessToken: googleAuth.accessToken,
// //           idToken: googleAuth.idToken,
// //         );

// //         final UserCredential userCredential = await _auth.signInWithCredential(credential);
// //         final User? user = userCredential.user;

// //         if (user != null) {
// //           // Navigate to the HomePage
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => AdminScreen()),
// //           );
// //         }
// //       }
// //     } catch (e) {
// //       print('Error during Google Sign-In: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Google Sign-In'),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: _signInWithGoogle,
// //           child: Text('Sign In with Google'),
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FacebookSignInController()),
//         ChangeNotifierProvider(create: (_) => GoogleSignInController()),
//       ],
//       child: MaterialApp(
//         title: 'Auth App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.active) {
//               if (snapshot.hasData) {
//                 return AdminScreen();
//               } else {
//                 return LoginPage1();
//               }
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }

// class AdminScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final facebookModel = Provider.of<FacebookSignInController>(context);
//     final googleModel = Provider.of<GoogleSignInController>(context);

//     final user = facebookModel.userData ?? googleModel.googleSignInAccount;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Screen'),
//       ),
//       body: Center(
//         child: user != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       facebookModel.userData != null
//                           ? facebookModel.userData!['picture']['data']['url']
//                           : googleModel.googleSignInAccount!.photoUrl!,
//                     ),
//                     radius: 50,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     facebookModel.userData != null
//                         ? facebookModel.userData!['name']
//                         : googleModel.googleSignInAccount!.displayName!,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     facebookModel.userData != null
//                         ? facebookModel.userData!['email']
//                         : googleModel.googleSignInAccount!.email!,
//                   ),
//                 ],
//               )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class LoginPage1 extends StatefulWidget {
//   @override
//   _LoginPage1State createState() => _LoginPage1State();
// }

// class _LoginPage1State extends State<LoginPage1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: LoginUI(),
//     );
//   }

//   Widget LoginUI() {
//     return Consumer2<FacebookSignInController, GoogleSignInController>(
//       builder: (context, facebookModel, googleModel, child) {
//         if (facebookModel.userData != null || googleModel.googleSignInAccount != null) {
//           return Center(
//             child: loggedInUI(),
//           );
//         } else {
//           return loginController(context);
//         }
//       },
//     );
//   }

//   Widget loggedInUI() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundImage: NetworkImage(Provider.of<FacebookSignInController>(context, listen: false).userData?['picture']['data']['url'] ?? ""),
//           radius: 50,
//         ),
//         SizedBox(height: 20),
//         Text(Provider.of<FacebookSignInController>(context, listen: false).userData?['name'] ?? "" 
//               ?? Provider.of<GoogleSignInController>(context, listen: false).googleSignInAccount?.displayName ?? "",
//               style: TextStyle(color: Colors.white, fontSize: 20)),
//         SizedBox(height: 10),
//         Text(Provider.of<FacebookSignInController>(context, listen: false).userData?['email'] ?? ""
//               ?? Provider.of<GoogleSignInController>(context, listen: false).googleSignInAccount?.email ?? "",
//               style: TextStyle(color: Colors.white)),
//         SizedBox(height: 20),
//         ActionChip(
//           label: Text("Logout"),
//           avatar: Icon(Icons.logout, color: Colors.white),
//           onPressed: () {
//             Provider.of<FacebookSignInController>(context, listen: false).logout();
//             Provider.of<GoogleSignInController>(context, listen: false).logout();
//           },
//         )
//       ],
//     );
//   }

//   Widget loginController(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.network(
//             "https://example.com/your-logo.png", // Replace with your logo URL
//             height: 80,
//             width: 100,
//           ),
//           SizedBox(height: 10),
//           Text(
//             'Log in to see more',
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 110),
//           GestureDetector(
//             child: Image.network(
//               "https://example.com/facebook-login-button.png", // Replace with your Facebook button image URL
//               width: 240,
//             ),
//             onTap: () {
//               Provider.of<FacebookSignInController>(context, listen: false).login().then((_) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => AdminScreen()),
//                 );
//               });
//             },
//           ),
//           SizedBox(height: 20),
//           GestureDetector(
//             child: Image.network(
//               "https://example.com/google-login-button.png", // Replace with your Google button image URL
//               width: 240,
//             ),
//             onTap: () {
//               Provider.of<GoogleSignInController>(context, listen: false).login().then((_) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => AdminScreen()),
//                 );
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FacebookSignInController with ChangeNotifier {
//   Map<String, dynamic>? userData;

//   Future<void> login() async {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: ['email', 'public_profile'],
//     );

//     if (result.status == LoginStatus.success) {
//       final requestData = await FacebookAuth.instance.getUserData(
//         fields: 'email,name,picture',
//       );
//       userData = requestData;
//       notifyListeners();
//     } else {
//       print(result.message); // Check for any error messages
//     }
//   }

//   Future<void> logout() async {
//     await FacebookAuth.instance.logOut();
//     userData = null;
//     notifyListeners();
//   }
// }

// class GoogleSignInController with ChangeNotifier {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? googleSignInAccount;

//   Future<void> login() async {
//     googleSignInAccount = await _googleSignIn.signIn();
//     notifyListeners();
//   }

//   Future<void> logout() async {
//     await _googleSignIn.signOut();
//     googleSignInAccount = null;
//     notifyListeners();
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   try {
//     await Firebase.initializeApp();
//     print("Firebase initialized successfully.");
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }

//   // Initialize Supabase
//   try {
//     await Supabase.initialize(
//       url: 'https://xnfmnmqgkaircknxijmr.supabase.co',
//       anonKey:
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuZm1ubXFna2FpcmNrbnhpam1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE3NDE0MDUsImV4cCI6MjAzNzMxNzQwNX0.JebiutGiRUGpdbjZKJB78mD2e6DaFNCNh2XXzKMcciA',
//     );
//     print("Supabase initialized successfully.");
//   } catch (e) {
//     print("Error initializing Supabase: $e");
//   }

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SignUpPage(),
//     );
//   }
// }

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<void> _signUpWithFirebase(String email, String password) async {
//     try {
//       firebase.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       print("Firebase user signed up!");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(user: userCredential.user),
//         ),
//       );
//     } catch (e) {
//       print("Firebase sign-up failed: $e");
//     }
//   }

//   Future<void> _signUpWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;

//       final firebase.AuthCredential credential = firebase.GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       firebase.UserCredential userCredential = await _auth.signInWithCredential(credential);
//       print("Google user signed up!");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(user: userCredential.user),
//         ),
//       );
//     } catch (e) {
//       print("Google sign-up failed: $e");
//     }
//   }


//   Future<void> _signUpWithFacebook() async {
//     try {
//       final LoginResult result = await FacebookAuth.instance.login();

//       if (result.status == LoginStatus.success) {
//         final firebase.OAuthCredential credential =
//             firebase.FacebookAuthProvider.credential(result.accessToken!.token);

//         firebase.UserCredential userCredential = await _auth.signInWithCredential(credential);
//         print("Facebook user signed up!");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(user: userCredential.user),
//           ),
//         );
//       } else {
//         print("Facebook login failed: ${result.message}");
//       }
//     } catch (e) {
//       print("Facebook sign-up failed: $e");
//     }
//   }

//   Future<void> _signUpWithSupabase(String email, String password) async {
//     final response = await supabase.Supabase.instance.client.auth.signUp(
//       email: email,
//       password: password,
//     );

//     if (response.user != null) {
//       print("Supabase user signed up!");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(supabaseUser: response.user),
//         ),
//       );
//     } else {
//       print("Supabase sign-up failed: ${response}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController emailController = TextEditingController();
//     final TextEditingController passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _signUpWithFirebase(
//                   emailController.text,
//                   passwordController.text,
//                 );
//               },
//               child: Text('Sign Up with Firebase'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _signUpWithGoogle();
//               },
//               child: Text('Sign Up with Google'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _signUpWithFacebook();
//               },
//               child: Text('Sign Up with Facebook'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _signUpWithSupabase(
//                   emailController.text,
//                   passwordController.text,
//                 );
//               },
//               child: Text('Sign Up with Supabase'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final firebase.User? user;
//   final supabase.User? supabaseUser;

//   HomePage({this.user, this.supabaseUser});

//   @override
//   Widget build(BuildContext context) {
//     String displayName = '';
//     String email = '';
//     String photoUrl = '';

//     if (user != null) {
//       displayName = user!.displayName ?? 'No Name';
//       email = user!.email ?? 'No Email';
//       photoUrl = user!.photoURL ?? '';
//     } else if (supabaseUser != null) {
//       displayName = supabaseUser!.email ?? 'No Name';
//       email = supabaseUser!.email ?? 'No Email';
//       // Supabase doesn't provide a photo URL by default
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (photoUrl.isNotEmpty)
//               CircleAvatar(
//                 backgroundImage: NetworkImage(photoUrl),
//                 radius: 50,
//               ),
//             SizedBox(height: 20),
//             Text('Welcome, $displayName'),
//             Text('Email: $email'),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:fbsocial/adminscreen.dart';
// import 'package:fbsocial/authentication/login.dart';
// import 'package:fbsocial/authentication/signup.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:fbsocial/screens/splashScreen.dart';
// import 'package:fbsocial/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   try {
//     await Firebase.initializeApp();
//     print("Firebase initialized successfully.");
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }

//   // Initialize Supabase
//   Supabase.initialize(
//     url: 'https://xnfmnmqgkaircknxijmr.supabase.co',
//     anonKey:
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuZm1ubXFna2FpcmNrbnhpam1yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE3NDE0MDUsImV4cCI6MjAzNzMxNzQwNX0.JebiutGiRUGpdbjZKJB78mD2e6DaFNCNh2XXzKMcciA',
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => FacebookSignInController(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Supabase Auth',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder(
//         future: _checkAuthStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SplashScreen(); // Show splash screen while checking auth status
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final isLoggedIn = snapshot.data as bool;
//             return isLoggedIn ? HomePage() : LoginPage();
//           }
//         },
//       ),
//       routes: {
//         '/splashScreen': (context) => SplashScreen(),
//         '/login': (context) => LoginPage(),
//         '/sign-up': (context) => SignUpPage(),
//         // '/homepage': (context) => HomePage(), // Note: HomePage is now managed by the home parameter
//       },
//     );
//   }

//   Future<bool> _checkAuthStatus() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // User is signed in with Firebase
//       return true;
//     }

//     final session = Supabase.instance.client.auth.session();
//     if (session != null) {
//       // User is signed in with Supabase
//       return true;
//     }

//     // No user is signed in
//     return false;
//   }
// }







import 'package:fbsocial/adminscreen.dart';
import 'package:fbsocial/authentication/login.dart';
import 'package:fbsocial/authentication/signup.dart';
import 'package:fbsocial/facebooksign.dart';
import 'package:fbsocial/screens/splashScreen.dart';
import 'package:fbsocial/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => FacebookSignInController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _checkAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(); // Show splash screen while checking auth status
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final isLoggedIn = snapshot.data as bool;
            return isLoggedIn ? HomePage() : LoginPage();
          }
        },
      ),
      routes: {
        '/splashScreen': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/sign-up': (context) => SignUpPage(),
        // '/homepage': (context) => HomePage(), // Note: HomePage is now managed by the home parameter
      },
    );
  }

  Future<bool> _checkAuthStatus() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return firebaseUser != null; // Return true if user is signed in with Firebase
  }
}
