import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

class Menu extends StatefulWidget {
  const Menu(
      this.sessionId, this.selectedTab, this.changeSession, this.changePage, this.restoreSession,
      {Key? key})
      : super(key: key);

  final void Function(int) changePage;
  final void Function(int) changeSession;
  final void Function(int) restoreSession;
  final int? sessionId;
  final int selectedTab;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(
          children: [
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
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.changePage(0);
                          print("Switched");
                        },
                        child: MenuItem(
                            icon: Icons.power_settings_new, text: "Dashboard"),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.changePage(1);
                          print("Switched");
                        },
                        child: MenuItem(
                            icon: Icons.chat_bubble_rounded, text: "Chats"),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.changePage(2);
                          print("Switched");
                        },
                        child:
                            MenuItem(icon: Icons.check_box, text: "Solution"),
                      ),
                    ],
                  ),
                ),
              ] +
              (widget.selectedTab == 1
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                html.window.location.reload();
                              },
                              child: MenuItem(
                                  icon: Icons.query_builder,
                                  text:
                                      "Session: ${widget.sessionId ?? 'None'}"),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(txtController.value.text != ""){
                                  widget.restoreSession(int.parse(txtController.value.text));
                                }
                              },
                              child: const MenuItem(
                                  icon: Icons.restore,
                                  text: "Restore session:"),
                            ),
                            Container(
                              width: 100,
                              height: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: 20,
                                  child: TextField(
                                    controller: txtController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Lato",
                                        decoration: TextDecoration.none,
                                        fontSize: 14),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "New Id",
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Lato",
                                            decoration: TextDecoration.none,
                                            fontSize: 14),
                                        filled: true,
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : []),
        ));
  }
}

class MenuItem extends StatefulWidget {
  const MenuItem({required this.icon, required this.text, Key? key})
      : super(key: key);
  final IconData? icon;
  final String text;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              widget.icon,
              size: 20,
              color: _isHovering ? Colors.blue : Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 80,
              child: Text(
                widget.text,
                style: TextStyle(
                    color: _isHovering ? Colors.blue : Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato",
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
