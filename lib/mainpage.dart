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
          const Flexible(
            flex: 20,
            child: Menu()
          ),
          Flexible(
            flex: 55,
            child: ChatListView(),
          ),
          const Flexible(
            flex: 25,
            child: Gamification(),
          )
        ],
      ),
    ]);
  }
}
