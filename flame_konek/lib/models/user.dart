import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String? id;
  final String? username;
  final String? email;
  final String? photoUrl;
  final String? displayName;
  final String? bio;
  final String? department;
  final String? course;


  User({this.id, this.username, this.email, this.photoUrl, this.displayName, this.bio, this.department, this.course});


  factory User.fromDocument(DocumentSnapshot doc){
    return User(
        id : doc['id'],
        username : doc['username'],
        email: doc['email'],
        photoUrl : doc['photoUrl'],
        displayName : doc['displayName'],
        bio : doc['bio'],
        department: doc['department'],
        course: doc['course']
    );
  }

}