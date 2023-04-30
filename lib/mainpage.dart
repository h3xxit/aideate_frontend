import 'dart:ui';

import "package:flutter/material.dart";
import 'package:watchat_ui/Gamification.dart';
import 'package:watchat_ui/SolutionView.dart';
import 'package:watchat_ui/chatListView.dart';
import 'package:watchat_ui/dashboard.dart';

import 'Menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedTab = 1;
  int? sessionId;

  Widget tabs(int selected) {
    switch(selected){
      case 0:
        return Dashboard();
      case 1:
        return ChatListView(sessionId, setSessionId);
      case 2:
        return SolutionView(sessionId);
      default:
        print("Something went wrong when selecting the tab");
        return ChatListView(sessionId, setSessionId);
    }
  }

  void setSessionId(int sessionId) {
    setState(() {
      this.sessionId = sessionId;
    });
  }

  void setSelectedTab(int tabNumber) {
    setState(() {
      if(sessionId == null && selectedTab == 2) {
        selectedTab = 1;
      } else {
        selectedTab = tabNumber;
      }
    });
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
              Flexible(flex: 20, child: Menu(sessionId, setSessionId, setSelectedTab)),
              Flexible(
                flex: (selectedTab == 1 ? 55 : 80),
                child: tabs(selectedTab),
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
