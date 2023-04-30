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
  void Function(int?)? refreshChat;

  Widget tabs(int selected) {
    switch (selected) {
      case 0:
        return Dashboard();
      case 1:
        return ChatListView(sessionId, setSessionId, setRefreshChat);
      case 2:
        return SolutionView(sessionId);
      default:
        print("Something went wrong when selecting the tab");
        return ChatListView(sessionId, setSessionId, setRefreshChat);
    }
  }

  void setRefreshChat(void Function(int?) refreshChat) {
    this.refreshChat = refreshChat;
  }

  void restoreSession(int sessionId) {
    setState(() {
      this.sessionId = sessionId;
    });
    if (refreshChat != null) {
      refreshChat!(sessionId);
    }
  }

  void setSessionId(int sessionId) {
    setState(() {
      this.sessionId = sessionId;
    });
  }

  void setSelectedTab(int tabNumber) {
    setState(() {
      if (sessionId == null && selectedTab == 2) {
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
          child: Image.network(
        "https://cdn.discordapp.com/attachments/1101777727679365180/1101885768877756456/Screenshot_2023-04-29_at_10.09.54.png",
        fit: BoxFit.cover,
      )),
      Row(
        children: [
              Flexible(
                  flex: 20,
                  child: Menu(sessionId, selectedTab, setSessionId,
                      setSelectedTab, restoreSession)),
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
