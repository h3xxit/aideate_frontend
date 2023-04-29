import 'dart:ui';

import "package:flutter/material.dart";
import 'package:watchat_ui/chatListView.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: const Color(0xff191a1a),
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "AIdeate",
                  style: TextStyle(color: Colors.white, fontFamily: "Lato"),
                )),
          ),
        ),
        Flexible(
            flex: 8,
            child: Stack(
              children: [
                const SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                /*SizedBox.expand(
                  child: Image.asset(
                    "assets/images/bluewallpaper.png",
                    fit: BoxFit.cover,
                  ),
                ),*/
                ChatListView()
              ],
            ))
      ],
    );
  }
}
