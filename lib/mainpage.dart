import 'dart:ui';

import "package:flutter/material.dart";
import 'package:watchat_ui/Gamification.dart';
import 'package:watchat_ui/chatListView.dart';
import 'package:watchat_ui/dashboard.dart';

import 'Menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> tabs = [Dashboard(), ChatListView(), ChatListView()];
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
              Flexible(flex: 20, child: Menu(setSelectedTab)),
              Flexible(
                flex: (selectedTab == 1 ? 55 : 80),
                child: tabs[selectedTab],
              ),
            ] +
            (selectedTab == 1
                ? [
                    const Flexible(
                      flex: 25,
                      child: Gamification(),
                    )
                  ]
                : []),
      ),
    ]);
  }
}
