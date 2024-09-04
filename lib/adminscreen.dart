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

import 'package:fbsocial/authentication/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:fbsocial/facebooksign.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fbsocial/screens/profile.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  HomePage({this.userData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late FacebookSignInController facebookSignInController;
  int _currentIndex = 0;
  final Color _backgroundColor =
      AppColors.backgroundColor; // Navigation bar background color
  final Color _iconColor = AppColors.whiteColor; // Default icon color

  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')),
    Center(child: Text('Search Page Content')),
    Center(child: Text('Add Page Content')),
    Center(child: Text('Notifications Page Content')),
    ProfilePage(), // Include the ProfilePage here, without passing data directly
  ];

  @override
  void initState() {
    super.initState();
    facebookSignInController =
        Provider.of<FacebookSignInController>(context, listen: false);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _backgroundColor, // Navigation bar background color
        automaticallyImplyLeading: false, // Removes the back arrow
        leadingWidth: 60, // Adjust the width of the leading widget area
        leading: widget.userData != null
            ? Padding(
                padding:
                    EdgeInsets.only(left: 16), // Adjust the left margin here
                child: Container(
                  child: CircleAvatar(
                    backgroundImage: widget.userData!['picture'] != null
                        ? NetworkImage(widget.userData!['picture'])
                        : null,
                    child: widget.userData!['picture'] == null
                        ? Text(widget.userData!['name']?[0] ?? 'U')
                        : null,
                    radius: 20,
                  ),
                ),
              )
            : null,
        title: widget.userData != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userData?['name'] ?? 'No Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _iconColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.userData?['email'] ?? 'No Email',
                    style: TextStyle(fontSize: 10, color: _iconColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : null,
        titleSpacing: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,
                color: _iconColor), // Ensure logout icon color matches
            onPressed: () async {
              // Show confirmation dialog
              bool confirmSignOut = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out'),
                    content: Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // User cancelled
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // User confirmed
                        },
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                },
              );

              // Proceed with sign out if confirmed
              if (confirmSignOut) {
                await googleSignIn.signOut();
                await auth.signOut();
                await facebookSignInController.logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
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
          Icon(Icons.notifications,
              size: 30,
              color: _currentIndex == 3 ? _backgroundColor : _iconColor),
          Icon(Icons.account_circle,
              size: 30,
              color: _currentIndex == 4 ? _backgroundColor : _iconColor),
        ],
        color: _backgroundColor, // Navigation bar background color
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
