import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rahbar/screens/progammingbookview.dart';

class EnrolledPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;


  static FirebaseAuth auth = FirebaseAuth.instance;

  // THIS LINE OF CODE IS TO ACCESS CLOUD FIRESTORE DATABASE
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //THIS LINE OF CODE IS  TO ACCESS FIREBASE STORAGE
  static FirebaseStorage storage = FirebaseStorage.instance;



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Programming Enrolled Programs"),
        ),
        body: user == null ? Center(child: Text("Please log in to view enrolled programs.")) : StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('programming enrollment')
              .doc(user!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> enrollmentSnapshot) {
            if (enrollmentSnapshot.hasError) {
              return Text('Something went wrong');
            }
            if (enrollmentSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!enrollmentSnapshot.data!.exists) {
              return Center(child: Text("You are not enrolled in any programs."));
            }
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('programming').where('enrolledUsers', arrayContains: user!.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> programSnapshot) {
                if (programSnapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (programSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView(
                  children: programSnapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgrammingBookView(
                            programmingUrl: data['programmingUrl'],
                            programmingId: data['programmingId'],
                            title: data['title'],
                            email: data['email'],
                            youtube: data['youtube'],
                            programmingImages: data['programmingImages'],
                            videoUrl: data['video'],
                            content: data['content'],
                          ),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            child: Image.network(
                              data['programmingUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    data['title'],
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
