import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rahbar/models/rahbar_user.dart' as model;

class AuthMethods {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static User get user => auth.currentUser!;

  Future<model.RahbarUser> getUserDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot documentSnapshot =
    await firestore.collection('users').doc(currentUser.uid).get();
    return model.RahbarUser.fromJson(documentSnapshot.data()! as Map<String, dynamic>);
  }
}
