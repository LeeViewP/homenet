import 'package:flutter/material.dart';

import './HomePage.dart';

class HomePageView extends HomePageState{
  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      body: navigationPages[currentIndex],
      bottomNavigationBar: new  BottomNavigationBar(
        currentIndex: currentIndex, 
        onTap: onTabTapped,
        items: navigationItems.toList(),
      ),
    );
  }
}