import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rahbar/screens/profile_screen.dart';

import '../api/apis.dart';
import '../authentication/login_screen.dart';
import '../coursepages/agriculture.dart';
import '../coursepages/dataanalysis.dart';
import '../coursepages/marketting.dart';
import '../coursepages/medicine.dart';
import '../coursepages/politics.dart';
import '../coursepages/programming.dart';
import '../helper/dialogs.dart';
import 'change_password_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController(); // Second PageController
  final List<String> titles = [
    'PROGRAMMING', 'MEDICINE', 'MARKETING', 'DATA ANALYSIS', 'AGRICULTURE', 'POLITICS'
  ];
  final List<String> images = [
    'assets/code.jpeg',
    'assets/medicine.jpeg',
    'assets/marketting.jpeg',
    'assets/dataanalysis.jpeg',
    'assets/agriculture.jpeg',
    'assets/politics.jpeg'
  ];
  final List<String> titles2 = [
    'AI', 'CLOUD COMPUTING', 'FINANCE', 'FIRST AID', 'ANALYSIS', 'AGENDA'
  ];
  final List<String> images2 = [
    'assets/ai.jpeg',
    'assets/cloudcomputing.jpeg',
    'assets/finance.jpeg',
    'assets/firstaid.png',
    'assets/analysis.jpeg',
    'assets/agenda.png'
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == 5) {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
      if (_pageController2.page == 5) {
        _pageController2.animateToPage(
          0,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        _pageController2.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Rahbar'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile Update'),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (_) => ProfileScreen(user: APIs.me),
                  //     ),
                  //   );
                  // },
                ),
      
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Change Password'),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (_) => ChangePasswordScreen(),
                  //     ),
                  //   );
                  // },
                ),
      
      
      
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () async {
                    //for showing progress dialog
                    Dialogs.showProgressBar(context);
      
                    await APIs.updateActiveStatus(false);
      
                    //sign out from app
                    await APIs.auth.signOut().then((value) async {
      
                        //for hiding progress dialog
                        Navigator.pop(context);
      
                        //for moving to home screen
                        Navigator.pop(context);
      
                        APIs.auth = FirebaseAuth.instance;
      
                        //replacing home screen with login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
      
                    });
                  },
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular Courses', style: Theme.of(context).textTheme.headlineMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PopularCourseViewAllPage()),
                        );
                      },
                      child: Text('VIEW ALL', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
      
      
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToCoursePage(context, index);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Text(
                                titles[index],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending Modules', style: Theme.of(context).textTheme.headlineMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TrendingModulesPage()),
                        );
                      },
                      child: Text('VIEW ALL', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController2,
                  itemCount: titles2.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToTrendingCoursePage(context, index);
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              images2[index],
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Text(
                                titles2[index],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      
            ],
          ),
        ),
    );

  }
  void navigateToCoursePage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProgrammingPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MedicinePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MarkettingPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => DataanalysisPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AgriculturePage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PoliticsPage()));
        break;
    }
  }



  void navigateToTrendingCoursePage(BuildContext context, int index) {
    switch (index) {
      // case 0:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AiPage()));
      //   break;
      // case 1:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => CloudcomputingPage()));
      //   break;
      // case 2:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => FinancePage()));
      //   break;
      // case 3:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => FirstaidPage()));
      //   break;
      // case 4:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AnalysisPage()));
      //   break;
      // case 5:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AgendaPage()));
      //   break;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageController2.dispose();
    super.dispose();
  }
}



class PopularCourseViewAllPage extends StatelessWidget {
  final List<String> titles = [
    'AI', 'CLOUD COMPUTING', 'FINANCE', 'FIRST AID', 'ANALYSIS', 'AGENDA'
  ];
  final List<String> images = [
    'assets/code.jpeg',
    'assets/medicine.jpeg',
    'assets/marketting.jpeg',
    'assets/dataanalysis.jpeg',
    'assets/agriculture.jpeg',
    'assets/politics.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Popular Courses"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              navigateToCoursePage(context, index);
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToCoursePage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProgrammingPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MedicinePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MarkettingPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => DataanalysisPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AgriculturePage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PoliticsPage()));
        break;
    }
  }
}










class TrendingModulesPage extends StatelessWidget {
  final List<String> titles = [
    'AI', 'CLOUD COMPUTING', 'FINANCE', 'FIRST AID', 'ANALYSIS', 'AGENDA'
  ];
  final List<String> images = [
    'assets/ai.jpeg',
    'assets/cloudcomputing.jpeg',
    'assets/finance.jpeg',
    'assets/firstaid.png',
    'assets/analysis.jpeg',
    'assets/agenda.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Trending Modules"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              navigateToModulePage(context, index);
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToModulePage(BuildContext context, int index) {
    switch (index) {
      // case 0:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AiPage()));
      //   break;
      // case 1:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => CloudcomputingPage()));
      //   break;
      // case 2:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => FinancePage()));
      //   break;
      // case 3:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => FirstaidPage()));
      //   break;
      // case 4:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AnalysisPage()));
      //   break;
      // case 5:
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AgendaPage()));
      //   break;
    }
  }
}


