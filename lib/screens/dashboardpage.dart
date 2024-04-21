import 'package:flutter/material.dart';

import '../coursepages/agriculture.dart';
import '../coursepages/coaching.dart';
import '../coursepages/dataanalysis.dart';
import '../coursepages/marketting.dart';
import '../coursepages/medicine.dart';
import '../coursepages/music.dart';
import '../coursepages/politics.dart';
import '../coursepages/programming.dart';


class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> books = [
    {"title": "PROGRAMMING", "image": "assets/code.jpeg", "page": ProgrammingPage()},
    {"title": "MARKETTING", "image": "assets/marketting.jpeg", "page": MarkettingPage()},
    {"title": "MUSIC", "image": "assets/music.jpeg", "page": MusicPage()},
    {"title": "MEDICINE", "image": "assets/medicine.jpeg", "page": MedicinePage()},
    {"title": "DATA ANALYSIS", "image": "assets/dataanalysis.jpeg", "page": DataanalysisPage()},
    {"title": "AGRICULTURE", "image": "assets/agriculture.jpeg", "page": AgriculturePage()},
    {"title": "POLITICS", "image": "assets/politics.jpeg", "page": PoliticsPage()},
    {"title": "COACHING", "image": "assets/coaching.png", "page": CoachingPage()},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Courses'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => books[index]['page'],
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        books[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          books[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
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
    );
  }
}
