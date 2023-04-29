import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.child, required this.isAi, Key? key})
      : super(key: key);
  final Widget child;
  final bool isAi;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Stack(
          children: List<Widget>.of(isAi
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Colors.black,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      )
                    ]
                  : []) +
              [
                Padding(
                  padding: EdgeInsets.only(left: (isAi ? 45.0 : 0.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        child: Container(
                          decoration: isAi
                              ? null
                              : const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-1, -1),
                                    end: Alignment(-0.9, 1.5),
                                    colors: [
                                      Colors.white,
                                      Color.fromARGB(255, 86, 193, 245)
                                    ],
                                  ),
                                ),
                          color: isAi ? Colors.white : null,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: child,
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ]),
    );
  }
}
