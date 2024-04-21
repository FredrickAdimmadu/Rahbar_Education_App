import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgrammingPage extends StatefulWidget {
  @override
  _ProgrammingPageState createState() => _ProgrammingPageState();
}

class _ProgrammingPageState extends State<ProgrammingPage> {
  bool _isEnrolled = false;
  final user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;


  static FirebaseAuth auth = FirebaseAuth.instance;

  // THIS LINE OF CODE IS TO ACCESS CLOUD FIRESTORE DATABASE
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //THIS LINE OF CODE IS  TO ACCESS FIREBASE STORAGE
  static FirebaseStorage storage = FirebaseStorage.instance;


  @override
  void initState() {
    super.initState();
    checkEnrollment();
  }

  void checkEnrollment() async {
    var doc = await _firestore
        .collection('programming enrollment')
        .doc(user!.uid)
        .get();

    setState(() {
      _isEnrolled = doc.exists;
    });
  }

  void toggleEnrollment() async {
    if (_isEnrolled) {
      await _firestore
          .collection('programming enrollment')
          .doc(user!.uid)
          .delete();
      setState(() {
        _isEnrolled = false;
      });
    } else {
      await _firestore
          .collection('programming enrollment')
          .doc(user!.uid)
          .set({'enrolled': true});
      setState(() {
        _isEnrolled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Programming Course'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/rahbar_icon.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Text>[
                      Text(
                        'Name: Fredrick Adimmadu',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      Text(
                        'Email: fredyadim@gmail.com',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Title: Programming',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              Text(
                'This course will impact ground breaking coding ideas and intellectuality into you thereby enabling you go beyond boundaries to be great.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 20,  // Larger text size
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  toggleEnrollment();
                },
                child: Text(_isEnrolled ? 'UNENROLL' : 'ENROLL'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _isEnrolled ? Colors.green : Colors.blue,
                ),
              ),
              if (_isEnrolled)
                Text('You are enrolled!', style: TextStyle(color: Colors.green, fontSize: 16)),
              if (!_isEnrolled)
                Text('You are not enrolled.', style: TextStyle(color: Colors.red, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
