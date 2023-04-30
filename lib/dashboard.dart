import 'dart:ui';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<bool> _isHoveringList = List.generate(6, (index) => false);

  Widget buildImageContainer(String url, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHoveringList[index] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHoveringList[index] = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: _isHoveringList[index]
              ? [
                  const BoxShadow(
                    color: Color.fromARGB(34, 0, 0, 0),
                    blurRadius: 11.0,
                    spreadRadius: 0,
                    offset: Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 60,
          bottom: 60,
          right: 60
      ),

      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        padding: EdgeInsets.all(16),
        children: [
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076961511182457/employees-widget.png", 0),
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076961867714570/report-widget.png", 1),
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076962505244793/automation-widget.png", 2),
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076963289567282/notes-widget.png", 3),
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076969581039616/positivity-widget.png", 4),
          buildImageContainer("https://cdn.discordapp.com/attachments/1101777727679365180/1102076970029826049/messages-widget.png", 5),
        ],
      ),
    );
  }
}
