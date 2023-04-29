import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width / 40),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 1, bottom: 1),
        child: ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 40),
            child: Material(
              elevation: 20,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: child,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
