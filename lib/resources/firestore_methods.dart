import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rahbar/models/courses_model/programming.dart';
import 'package:rahbar/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';


class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseAuth auth = FirebaseAuth.instance;

  static User get user => auth.currentUser!;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;


  static Future<String> uploadProgramming( String name,  String email,  String youtube, String videoUrl, String imageUrls, String title, String content, Uint8List file,

      ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String programmingimage =
      await StorageMethods().uploadImageToStorage('programming', file, true);
      String programmingId = const Uuid().v1(); // creates unique id based on time
      Programming rahbarUser = Programming(
        name: name,
        email: email,
        youtube: youtube,
        video: videoUrl,
        programmingImages: imageUrls,
        title: title,
        content: content,
        programmingId: programmingId,
        programmingUrl: programmingimage,
        datePublished: DateTime.now(),
      );


      firestore.collection('programming')
          .doc(programmingId)
          .set(rahbarUser.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}