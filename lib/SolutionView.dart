import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';

import 'design/fontSizes.dart';

class SolutionView extends StatefulWidget {
  const SolutionView({super.key});

  @override
  State<SolutionView> createState() => _SolutionViewState();
}

class _SolutionViewState extends State<SolutionView> {
  List<Widget> childList = [];
  Widget build(BuildContext context) {
    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;
      return 
        Container(
          margin: EdgeInsets.only(bottom: inputHeight + 55),
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(60, 60, 60, 40),
            children: childList,
          ),
        );
  }




  void addChat(List<Widget> widgets) {
    List<Widget> tmp = List.of(childList);
    for (Widget widget in widgets) {
      tmp.insert(
          0,
          Container(
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).size.height / 20),
            child: widget,
          ));
      setState(() {
        childList = tmp;
      });
    }
  }


  



}

class SolutionText extends StatelessWidget {
  const SolutionText(this.solutionText, {super.key});

  final String solutionText;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ChatMessage(
        isAi: false,
        child: Text(
          solutionText,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "Lato",
              decoration: TextDecoration.none,
              fontSize: 20,
        ),
      ),
    ));
  }
}