// import 'package:fbsocial/adminscreen.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:fbsocial/googlesignin.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class LoginPage1 extends StatelessWidget {
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
//             child: loggedInUI(context),
//           );
//         } else {
//           return loginController(context);
//         }
//       },
//     );
//   }

//   Widget loggedInUI(BuildContext context) {
//     final googleModel = Provider.of<GoogleSignInController>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundImage: NetworkImage(googleModel.googleSignInAccount?.photoUrl ?? ""),
//           radius: 50,
//         ),
//         SizedBox(height: 20),
//         Text(googleModel.googleSignInAccount?.displayName ?? "", style: TextStyle(color: Colors.white, fontSize: 20)),
//         SizedBox(height: 10),
//         Text(googleModel.googleSignInAccount?.email ?? "", style: TextStyle(color: Colors.white)),
//         SizedBox(height: 20),
//         ActionChip(
//           label: Text("Logout"),
//           avatar: Icon(Icons.logout, color: Colors.white),
//           onPressed: () {
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
//                   MaterialPageRoute(builder: (context) => HomePage()),
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
//               Provider.of<GoogleSignInController>(context, listen: false).login(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
