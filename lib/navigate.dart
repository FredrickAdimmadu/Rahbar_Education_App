import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rahbar/screens/dashboardpage.dart';
import 'package:rahbar/screens/enrolledpage.dart';
import 'package:rahbar/screens/homepage.dart';
import 'package:rahbar/screens/notificationpage.dart';

class NavigatePage extends StatefulWidget {
  @override
  _NavigatePageState createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  int _selectedIndex = 0;

  String deviceModel = '';
  String deviceVersion = '';
  String deviceLocation = '';
  String ipAddress = '';

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DashboardPage(),
    NotificationPage(),
    EnrolledPage()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // When 'Post' page is selected, capture device information and save to Firestore
    if ( index == 3 || index == 2 || index == 1 || index == 0) {
      getDeviceInfo();
    }
  }

  User? get user => FirebaseAuth.instance.currentUser;

  void getDeviceInfo() async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;

    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }

    String modelName = androidInfo?.model ?? iosInfo?.model ?? 'Unknown';
    String version = androidInfo?.version.release ?? iosInfo?.systemVersion ?? 'Unknown';

    setState(() {
      deviceModel = modelName;
      deviceVersion = version;
    });

    // Fetch device location
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        deviceLocation = 'Location: Loading...'; // Clear the location text while fetching
      });

      // Reverse geocode the coordinates to get the city and country
      placemarkFromCoordinates(position.latitude, position.longitude).then((placemarks) {
        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          final city = placemark.locality ?? 'Unknown';
          final country = placemark.country ?? 'Unknown';

          setState(() {
            deviceLocation = 'Location: $city, $country';
          });

          // Fetch IP address
          fetchIpAddress();

          // Save device information to Firebase Firestore
          saveToDeviceCollection(modelName, version, '$city, $country', ipAddress);
        }
      }).catchError((e) {
        print('Error getting location: $e');
      });
    }).catchError((e) {
      print('Error getting location: $e');
    });
  }

  // Function to fetch IP address
  void fetchIpAddress() async {
    final response = await http.get(Uri.parse('https://api64.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final ipAddress = response.body;
      setState(() {
        this.ipAddress = 'IP Address: $ipAddress';
      });
    } else {
      print('Error fetching IP address: ${response.statusCode}');
    }
  }

  DateTime currentDateTime = DateTime.now();
  // Function to save device information to Firebase Firestore
  // Function to save device information to Firebase Firestore
  Future<void> saveToDeviceCollection(
      String deviceModel,
      String deviceVersion,
      String deviceLocation,
      String ipAddress,
      ) async {
    CollectionReference deviceCollection = FirebaseFirestore.instance.collection('users_device');

    await deviceCollection.doc(user!.uid).set({
      'deviceModel': deviceModel,
      'deviceVersion': deviceVersion,
      'deviceLocation': deviceLocation,
      'ipAddress': ipAddress,
      'id': user!.uid,
      'name': user!.displayName ?? 'Unknown',
      'email': user!.email ?? 'Unknown',
      'image': user!.photoURL ?? 'Unknown',
      'dateAndTime': DateTime.now(),
    }, SetOptions(merge: true)); // Use merge option to update the document if it exists


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: CupertinoColors.activeBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: CupertinoColors.activeBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
            backgroundColor: CupertinoColors.activeBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_added_rounded),
            label: 'Enrolled',
            backgroundColor: CupertinoColors.activeBlue,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
