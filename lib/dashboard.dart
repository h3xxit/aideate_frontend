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

  Widget buildImageContainer(String assetPath, int index) {
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
                image: AssetImage(assetPath),
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
          buildImageContainer("/images/employees-widget.png", 0),
          buildImageContainer("/images/report-widget.png", 1),
          buildImageContainer("/images/automation-widget.png", 2),
          buildImageContainer("/images/notes-widget.png", 3),
          buildImageContainer("/images/positivity-widget.png", 4),
          buildImageContainer("/images/messages-widget.png", 5),
        ],
      ),
    );
  }
}
