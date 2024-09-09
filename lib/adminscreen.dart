// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fbsocial/screens/profile.dart';

// class HomePage extends StatefulWidget {
//   final Map<String, dynamic>? userData;

//   HomePage({this.userData});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   late FacebookSignInController facebookSignInController;
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     Center(child: Text('Home Page Content')),
//     Center(child: Text('Search Page Content')),
//     Center(child: Text('Add Page Content')),
//     Center(child: Text('Notifications Page Content')),
//     ProfilePage(), // Include the ProfilePage here, without passing data directly
//   ];

//   @override
//   void initState() {
//     super.initState();
//     facebookSignInController = Provider.of<FacebookSignInController>(context, listen: false);
//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar:
// AppBar(
//   backgroundColor: Color(0xFFFFBE00), // Your custom color
//   automaticallyImplyLeading: false, // Removes the back arrow
//   leadingWidth: 60, // Adjust the width of the leading widget area
//   leading: widget.userData != null
//       ? Padding(
//           padding: EdgeInsets.only(left: 16), // Adjust the left margin here
//           child: Container(
//             // padding: EdgeInsets.symmetric(horizontal: 2),
//             child:
//             CircleAvatar(
//               backgroundImage: widget.userData!['picture'] != null
//                   ? NetworkImage(widget.userData!['picture'])
//                   : null,
//               child: widget.userData!['picture'] == null
//                   ? Text(widget.userData!['name']?[0] ?? 'U')
//                   : null,
//               radius: 20,
//             ),

//           ),
//         )
//       : null,

//   title: widget.userData != null
//       ? Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.userData?['name'] ?? 'No Name',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               widget.userData?['email'] ?? 'No Email',
//               style: TextStyle(fontSize: 10),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         )
//       : null,
//       titleSpacing: 10,
//   actions: [
//     IconButton(
//       icon: Icon(Icons.logout),
//       onPressed: () async {
//         // Show confirmation dialog
//         bool confirmSignOut = await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Sign Out'),
//               content: Text('Are you sure you want to sign out?'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false); // User cancelled
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true); // User confirmed
//                   },
//                   child: Text('Sign Out'),
//                 ),
//               ],
//             );
//           },
//         );

//         // Proceed with sign out if confirmed
//         if (confirmSignOut) {
//           await googleSignIn.signOut();
//           await auth.signOut();
//           await facebookSignInController.logout();
//           Navigator.of(context).popUntil((route) => route.isFirst);
//         }
//       },
//     ),
//   ],
// )
// ,
//       bottomNavigationBar: CurvedNavigationBar(
//         items: <Widget>[
//           Icon(Icons.home, size: 30),
//           Icon(Icons.search, size: 30),
//           Container(
//             width: 50,
//             height: 50,
//             decoration:BoxDecoration(
//               borderRadius: BorderRadius.circular(50,),
//               border: Border.all(
//                 color: Color(0xFFFFBE00),
//                 width: 5
//               )

//             )

//              ,child: Icon(Icons.add, size: 30)),
//           Icon(Icons.notifications, size: 30),
//           Icon(Icons.account_circle, size: 30),
//         ],
//         color: Color(0xFFFFBE00), // Using specified color
//         backgroundColor: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         height: 55,
//         index: _currentIndex,
//         onTap: _onTabTapped,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),
//     );
//   }
// }






















































// import 'package:fbsocial/authentication/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fbsocial/screens/profile.dart';

// class HomePage extends StatefulWidget {
//   final Map<String, dynamic>? userData;

//   HomePage({this.userData});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   late FacebookSignInController facebookSignInController;
//   int _currentIndex = 0;
//   final Color _backgroundColor =
//       AppColors.backgroundColor; // Navigation bar background color
//   final Color _iconColor = AppColors.whiteColor; // Default icon color

//   final List<Widget> _pages = [
//     Center(child: Text('Home Page Content')),
//     Center(child: Text('Search Page Content')),
//     Center(child: Text('Add Page Content')),
//     Center(child: Text('Notifications Page Content')),
//     ProfilePage(), // Include the ProfilePage here, without passing data directly
//   ];

//   @override
//   void initState() {
//     super.initState();
//     facebookSignInController =
//         Provider.of<FacebookSignInController>(context, listen: false);
//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: _backgroundColor, // Navigation bar background color
//         automaticallyImplyLeading: false, // Removes the back arrow
//         leadingWidth: 60, // Adjust the width of the leading widget area
//         leading: widget.userData != null
//             ? Padding(
//                 padding:
//                     EdgeInsets.only(left: 16), // Adjust the left margin here
//                 child: Container(
//                   child: CircleAvatar(
//                     backgroundImage: widget.userData!['picture'] != null
//                         ? NetworkImage(widget.userData!['picture'])
//                         : null,
//                     child: widget.userData!['picture'] == null
//                         ? Text(widget.userData!['name']?[0] ?? 'U')
//                         : null,
//                     radius: 20,
//                   ),
//                 ),
//               )
//             : null,
//         title: widget.userData != null
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.userData?['name'] ?? 'No Name',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: _iconColor),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     widget.userData?['email'] ?? 'No Email',
//                     style: TextStyle(fontSize: 10, color: _iconColor),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               )
//             : null,
//         titleSpacing: 10,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout,
//                 color: _iconColor), // Ensure logout icon color matches
//             onPressed: () async {
//               // Show confirmation dialog
//               bool confirmSignOut = await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Sign Out'),
//                     content: Text('Are you sure you want to sign out?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(false); // User cancelled
//                         },
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(true); // User confirmed
//                         },
//                         child: Text('Sign Out'),
//                       ),
//                     ],
//                   );
//                 },
//               );

//               // Proceed with sign out if confirmed
//               if (confirmSignOut) {
//                 await googleSignIn.signOut();
//                 await auth.signOut();
//                 await facebookSignInController.logout();
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               }
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         items: <Widget>[
//           Icon(Icons.home,
//               size: 30,
//               color: _currentIndex == 0 ? _backgroundColor : _iconColor),
//           Icon(Icons.search,
//               size: 30,
//               color: _currentIndex == 1 ? _backgroundColor : _iconColor),
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(
//                 color: _backgroundColor,
//                 width: 5,
//               ),
//             ),
//             child: Icon(Icons.add,
//                 size: 30,
//                 color: _currentIndex == 2 ? _backgroundColor : _iconColor),
//           ),
//           Icon(Icons.notifications,
//               size: 30,
//               color: _currentIndex == 3 ? _backgroundColor : _iconColor),
//           Icon(Icons.account_circle,
//               size: 30,
//               color: _currentIndex == 4 ? _backgroundColor : _iconColor),
//         ],
//         color: _backgroundColor, // Navigation bar background color
//         backgroundColor: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         height: 55,
//         index: _currentIndex,
//         onTap: _onTabTapped,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),
//     );
//   }
// }




















































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fbsocial/authentication/colors.dart';
// import 'package:fbsocial/authentication/login.dart';
// import 'package:fbsocial/screens/student/savedata.dart';
// import 'package:fbsocial/screens/student/userList.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fbsocial/screens/profile.dart';

// class HomePage extends StatefulWidget {
//   final Map<String, dynamic>? userData;

//   HomePage({this.userData});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   late FacebookSignInController facebookSignInController;
//   int _currentIndex = 0;
//   final Color _backgroundColor =
//       AppColors.backgroundColor; // Navigation bar background color
//   final Color _iconColor = AppColors.whiteColor; // Default icon color

//   final List<Widget> _pages = [
//     Center(child: Text('Home Page Content')),
//     Center(child: Text('Search Page Content')),
//     AddDataPage(),
//     // UserListPage(),
//     ProfilePage(), // Include the ProfilePage here, without passing data directly
//     ProfilePage(), // Include the ProfilePage here, without passing data directly
//   ];

//   @override
//   void initState() {
//     super.initState();
//     facebookSignInController =
//         Provider.of<FacebookSignInController>(context, listen: false);
//     if (widget.userData != null) {
//       addUserToFirestore(widget.userData!);
//     }
//   }

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   Future<void> addUserToFirestore(Map<String, dynamic> userData) async {
//     final userRef = FirebaseFirestore.instance.collection('users').doc(userData['email']);

//     try {
//       await userRef.set({
//         'name': userData['name'],
//         'email': userData['email'],
//         'picture': userData['picture'],
//       });
//       print('User added to Firestore');
//     } catch (e) {
//       print('Error adding user to Firestore: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: _backgroundColor, // Navigation bar background color
//         automaticallyImplyLeading: false, // Removes the back arrow
//         leadingWidth: 60, // Adjust the width of the leading widget area
//         leading: widget.userData != null
//             ? Padding(
//                 padding:
//                     EdgeInsets.only(left: 16), // Adjust the left margin here
//                 child: Container(
//                   child: CircleAvatar(
//                     backgroundImage: widget.userData!['picture'] != null
//                         ? NetworkImage(widget.userData!['picture'])
//                         : null,
//                     child: widget.userData!['picture'] == null
//                         ? Text(widget.userData!['name']?[0] ?? 'U')
//                         : null,
//                     radius: 20,
//                   ),
//                 ),
//               )
//             : null,
//         title: widget.userData != null
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.userData?['name'] ?? 'No Name',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: _iconColor),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     widget.userData?['email'] ?? 'No Email',
//                     style: TextStyle(fontSize: 10, color: _iconColor),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               )
//             : null,
//         titleSpacing: 10,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout,
//                 color: _iconColor), // Ensure logout icon color matches
//             onPressed: () async {
//               // Show confirmation dialog
//               bool confirmSignOut = await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Sign Out'),
//                     content: Text('Are you sure you want to sign out?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(false); // User cancelled
//                         },
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//   // Show confirmation dialog
//   bool confirmSignOut = await showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Sign Out'),
//         content: Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(false); // User cancelled
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true); // User confirmed
//             },
//             child: Text('Sign Out'),
//           ),
//         ],
//       );
//     },
//   );

//   // Proceed with sign out if confirmed
//   if (confirmSignOut) {
//     try {
//       // Sign out from Google, Firebase, and Facebook
//       await googleSignIn.signOut();
//       await auth.signOut();
//       await facebookSignInController.logout();

//       // Clear user data (optional but recommended)
//       setState(() {
//         widget.userData?.clear();
//       });

//       // Navigate back to the login screen
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginPage()),
//         (Route<dynamic> route) => false, // Remove all routes from the stack
//       );
//     } catch (e) {
//       print('Error during sign out: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error signing out: $e')),
//       );
//     }
//   }
// },

//                         child: Text('Sign Out'),
//                       ),
//                     ],
//                   );
//                 },
//               );

//               // Proceed with sign out if confirmed
//               if (confirmSignOut) {
//                 await googleSignIn.signOut();
//                 await auth.signOut();
//                 await facebookSignInController.logout();
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               }
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         items: <Widget>[
//           Icon(Icons.home,
//               size: 30,
//               color: _currentIndex == 0 ? _backgroundColor : _iconColor),
//           Icon(Icons.search,
//               size: 30,
//               color: _currentIndex == 1 ? _backgroundColor : _iconColor),
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(
//                 color: _backgroundColor,
//                 width: 5,
//               ),
//             ),
//             child: Icon(Icons.add,
//                 size: 30,
//                 color: _currentIndex == 2 ? _backgroundColor : _iconColor),
//           ),
//           Icon(Icons.list,
//               size: 30,
//               color: _currentIndex == 3 ? _backgroundColor : _iconColor),
//           Icon(Icons.account_circle,
//               size: 30,
//               color: _currentIndex == 4 ? _backgroundColor : _iconColor),
//         ],
//         color: _backgroundColor, // Navigation bar background color
//         backgroundColor: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         height: 55,
//         index: _currentIndex,
//         onTap: _onTabTapped,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),
//     );
//   }
// }







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbsocial/authentication/colors.dart';
import 'package:fbsocial/authentication/login.dart';
import 'package:fbsocial/screens/company/adddoctor.dart';
import 'package:fbsocial/screens/company/company.dart';
// import 'package:fbsocial/screens/student/adddata.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:fbsocial/facebooksign.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fbsocial/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late FacebookSignInController facebookSignInController;
  int _currentIndex = 0;
  final Color _backgroundColor = AppColors.backgroundColor;
  final Color _iconColor = AppColors.whiteColor;

  Map<String, dynamic>? _userData;

  final List<Widget> _pages = [
    CompanyHomePage(),
    Center(child: Text('Search Page Content')),
    Center(
      child: ElevatedButton(onPressed: 
      addDoctorsData, child: Text("add data")),
    ),
    // UserListPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    facebookSignInController =
        Provider.of<FacebookSignInController>(context, listen: false);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Use user.uid to fetch user data
            .get();
        if (userDoc.exists) {
          setState(() {
            _userData = userDoc.data();
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      await facebookSignInController.logout();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error during sign out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        automaticallyImplyLeading: false,
        leadingWidth: 60,
        leading: _userData != null
            ? Padding(
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  child: CircleAvatar(
                    backgroundImage: _userData!['profilePictureUrl'] != null
                        ? NetworkImage(_userData!['profilePictureUrl'])
                        : null,
                    child: _userData!['profilePictureUrl'] == null
                        ? Text(_userData!['name']?[0] ?? 'U')
                        : null,
                    radius: 20,
                  ),
                ),
              )
            : null,
            centerTitle: false,
        title: _userData != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userData?['name'] ?? 'No Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _iconColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _userData?['email'] ?? 'No Email',
                    style: TextStyle(fontSize: 10, color: _iconColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : null,
        titleSpacing: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: _iconColor),
            onPressed: () async {
              bool confirmSignOut = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out'),
                    content: Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                },
              );

              if (confirmSignOut) {
                await _signOut();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home,
              size: 30,
              color: _currentIndex == 0 ? _backgroundColor : _iconColor),
          Icon(Icons.search,
              size: 30,
              color: _currentIndex == 1 ? _backgroundColor : _iconColor),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: _backgroundColor,
                width: 5,
              ),
            ),
            child: Icon(Icons.add,
                size: 30,
                color: _currentIndex == 2 ? _backgroundColor : _iconColor),
          ),
          Icon(Icons.list,
              size: 30,
              color: _currentIndex == 3 ? _backgroundColor : _iconColor),
          Icon(Icons.account_circle,
              size: 30,
              color: _currentIndex == 4 ? _backgroundColor : _iconColor),
        ],
        color: _backgroundColor,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 55,
        index: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
