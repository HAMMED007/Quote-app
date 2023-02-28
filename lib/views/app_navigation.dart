import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/quotesController.dart';
import 'package:qoutes_app/views/daily_qoutes.dart';
import 'package:qoutes_app/views/favourites_page.dart';
import 'package:qoutes_app/views/home.dart';
import 'package:qoutes_app/views/profile.dart';
import 'package:qoutes_app/views/utils/app_locals.dart';

import 'styles.dart';

class AppNavigation extends StatefulWidget {
  AppNavigation({Key? key}) : super(key: key);

  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;
  QuoteController quoteController = Get.find(tag: 'quoteController');

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DailyQoutes(),
    FavouritePage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: secondaryColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage('assets/home.png'),
                ),
                label: AppLocale.home.getString(context),
                backgroundColor: whiteColor),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage('assets/qoutes.png'),
                ),
                label: AppLocale.dailyQuotes.getString(context),
                backgroundColor: whiteColor),
            BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage('assets/favourite.png'),
                ),
                label: AppLocale.favourites.getString(context),
                backgroundColor: whiteColor),
            BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/profile.png'),
              ),
              label: AppLocale.profile.getString(context),
              backgroundColor: whiteColor,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
