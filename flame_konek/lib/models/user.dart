import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? username;
  final String? email;
  final String? photoUrl;
  final String? displayName;
  final String? bio;
  final String? department;
  final String? course;


  UserModel({this.id, this.username, this.email, this.photoUrl, this.displayName, this.bio, this.department, this.course});


  factory UserModel.fromDocument(DocumentSnapshot doc){
    return UserModel(
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