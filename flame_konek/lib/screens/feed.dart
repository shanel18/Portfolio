import 'package:flame_konek/screens/home.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();


}

UserModel? myUser;

class _FeedPageState extends State<FeedPage> {


@override
  void initState() {
    // TODO: implement initState
    myUser = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: ListView(
        children: <Widget> [
          Text('${myUser?.username}'),
           Text('${myUser?.department}'),
            Text('${myUser?.course}'),
             Text('${myUser?.bio}'),
              Text('${myUser?.displayName}'),
          
        ],
      ),
    );
  }
}
