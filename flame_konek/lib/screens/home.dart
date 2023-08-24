import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flame_konek/models/account_setup_model.dart';
import 'package:flame_konek/screens/account_setup.dart';
import 'package:flame_konek/screens/post.dart';
import 'package:flame_konek/screens/profile.dart';
import 'package:flame_konek/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import 'feed.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final DateTime timestamp = DateTime.now();
final usersReference = FirebaseFirestore.instance.collection('Users');

User? currentUser;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
    late PageController pageController;
  int index = 0;
  


  void login() async {
    googleSignIn.signIn();

    
  }

  @override
  void initState() {
    super.initState();
     pageController = PageController();

    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error Signing in: $err');
    });
  }



  handleSignIn(GoogleSignInAccount? account) async {
    if (account != null) {
      await createUserMethod();
      print(account);

      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserMethod() async {
    final GoogleSignInAccount? user = googleSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.doc(user?.id).get();

    if (!documentSnapshot.exists) {
      final AccountSetupArguments accountSetupArguments = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => AccountSetup()));

      usersReference.doc(user?.id).set({
        "id": user?.id,
        "username": accountSetupArguments.someMapVariable["username"],
        "photoUrl": user?.photoUrl,
        "email": user?.email,
        "displayName": user?.displayName,
        "bio": accountSetupArguments.someMapVariable["bio"],
        "timestamp": timestamp,
        "department": accountSetupArguments.someMapVariable["department"],
        "course": accountSetupArguments.someMapVariable["course"]
      });
      documentSnapshot = await usersReference.doc(user?.id).get();
    }

    currentUser = User.fromDocument(documentSnapshot);
    print(currentUser);
    print(currentUser?.displayName);
  }

  void signOut() {
    googleSignIn.signOut();
    
  }

    @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int index) {
    setState(() {
      this.index = index;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutCirc);
  }

  Widget openUser() {
     return Scaffold(
      body: PageView(
        children: <Widget>[
          FeedPage(), 
          ElevatedButton(onPressed: signOut, child: Text('logout'))
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        color: Colors.yellowAccent,
        items: [
        Icon(Icons.timeline_outlined),
        Icon(Icons.search),

      ],
      index: index,
      onTap: onTap,
      
      
      ),





      // Container(
      //   color: const Color(0xffEDEADE),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 8),
      //     child: GNav(
      //       backgroundColor: const Color(0xffEDEADE),
      //       color: const Color(0xff01444b),
      //       activeColor: const Color(0xffF8F8FF),
      //       tabBackgroundColor: const Color(0xff28282B),
      //       padding: const EdgeInsets.all(16),
      //       gap: 8,
      //       tabs: const [
      //         GButton(
      //           icon: Icons.timeline_outlined,
      //           text: 'Feed',
      //         ),
      //         GButton(
      //           icon: Icons.search,
      //           text: 'Search',
      //         ),
             
      //       ],
      //       selectedIndex: index,
      //       onTabChange: onTap,
      //     ),
      //   ),
      // ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        
        children: [
          SpeedDialChild(
            child: Icon(Icons.add_circle),
            label: 'add post',
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context){
      return PostPage();

    }));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.account_circle_rounded),
            label: 'View profile',
            onTap: () {
              Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.notification_important_rounded),
            label: 'notifications',
            onTap: () {
              Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          )
        ],
      ),
    );
  }

  
  
  Widget login_page() {
    return Scaffold(
      
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/images/logo2.png', width: 150, height: 150,),
           SizedBox(height: 80,),
            
            Text(
              'Flame Konek',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? openUser() : login_page();
  }
}
