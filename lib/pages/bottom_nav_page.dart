import 'package:film_ku/pages/home_page.dart';
import 'package:film_ku/resources/colors.dart';
import 'package:film_ku/resources/dummy_data.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: kHighlightColor,
          type: BottomNavigationBarType.fixed,
          onTap: (tappedIndex) {
            setState(() {
              currentIndex = tappedIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Search",
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
              label: "Downloads",
              icon: Icon(
                Icons.download_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
