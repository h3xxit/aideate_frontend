import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "AIdeate",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                fontSize: 40),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: Colors.black,
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lato",
                            fontSize: 25),
                      ),
                      Text(
                        "Otto Muller",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Lato",
                            fontSize: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: const [
              MenuItem(icon: Icons.power_settings_new, text: "Dashboard"),
              MenuItem(icon: Icons.chat_bubble_rounded, text: "Chats"),
              MenuItem(icon: Icons.calendar_today_outlined, text: "Schedule"),
              MenuItem(icon: Icons.settings, text: "Settings"),
              MenuItem(icon: Icons.query_builder, text: "History"),
            ],
          ),
        ),
      ]),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({required this.icon, required this.text, Key? key})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            size: 20,
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 80,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold, fontFamily: "Lato", fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
