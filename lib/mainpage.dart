import 'dart:ui';

import "package:flutter/material.dart";
import 'package:watchat_ui/Gamification.dart';
import 'package:watchat_ui/chatListView.dart';

import 'Menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> tabs = [ChatListView(), ChatListView(), ChatListView()];
  int selectedTab = 2;

  void setSelectedTab(int tabNumber) {
    setState(() {
      selectedTab = tabNumber;
    });
    print(tabNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox.expand(
        child: Image.asset(
          "images/wallpaper.png",
          fit: BoxFit.cover,
        ),
      ),
      Row(
        children: [
          Flexible(
            flex: (MediaQuery.of(context).size.width < 600 ? 0 : 20),
            child: Menu(setSelectedTab)
          ),
          Flexible(
            flex: 55,
            child: tabs[selectedTab],
          ),
          Flexible(
            flex: (MediaQuery.of(context).size.width < 600 ? 0 : 25),
            child: Gamification(),
          )
        ],
      ),
    ]);
  }
}
