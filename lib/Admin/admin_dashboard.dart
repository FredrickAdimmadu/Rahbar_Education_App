import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';
import 'courses_admin/programming_admin.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
          title: Text("Admin Dashboard"),
        ),
        body: SafeArea(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              _buildCard(context, "PROGRAMMING", Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgrammingAdmin()),
                );
              }),
              _buildCard(context, "MEDICINE", Colors.red, () {}),
              _buildCard(context, "MARKETING", Colors.green, () {}),
              _buildCard(context, "DATA ANALYSIS", Colors.purple, () {}),
              _buildCard(context, "AGRICULTURE", Colors.orange, () {}),
              _buildCard(context, "POLITICS", Colors.yellow, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

