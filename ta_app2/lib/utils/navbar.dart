import 'package:ta_app2/pages/adddevice.dart';
import 'package:ta_app2/pages/calculation.dart';
import 'package:ta_app2/pages/home.dart';
import 'package:ta_app2/pages/information.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _scannerActive = false;
  int _currentPage = 0;

  final routes = {
    '/home': (BuildContext context) => MyHomePage(),
    '/information': (BuildContext context) => InformationPage(),
    '/calculate': (BuildContext context) => CalculationPage(),
  };

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screens =
        routes.values.map((pageBuilder) => pageBuilder(context)).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Color(0xff80AF81),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_device_information,
            ),
            activeIcon: Icon(
              Icons.perm_device_information,
              color: Colors.white,
            ),
            label: 'Informasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate_rounded,
            ),
            activeIcon: Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            label: 'Kalkulasi',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.add,
          //   ),
          //   activeIcon: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          //   label: 'Tambah',
          // ),
        ],
      ),
    );
  }
}
