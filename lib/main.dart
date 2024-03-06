import 'package:flutter/material.dart';
import 'package:pilem/screens/favorite_screen.dart';
import 'package:pilem/screens/home_screen.dart';
import 'package:pilem/screens/search_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pilem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search'
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite'
          ),
        ],
      ),
    );
  }
}
