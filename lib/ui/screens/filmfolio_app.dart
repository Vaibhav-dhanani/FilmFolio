import 'package:filmfolio/ui/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'user_account_screen.dart';

class FilmfolioApp extends StatefulWidget {
  const FilmfolioApp({super.key});

  @override
  _FilmfolioAppState createState() => _FilmfolioAppState();
}

class _FilmfolioAppState extends State<FilmfolioApp> {
  int _currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    WatchlistScreen(),
    CategoryScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "WatchList",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
            backgroundColor: Colors.black,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.amber),
        showUnselectedLabels: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}

