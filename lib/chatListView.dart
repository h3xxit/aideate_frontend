import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/design/fontSizes.dart';
import 'package:watchat_ui/movieDetailView.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';


class ChatListView extends StatefulWidget {
  int count = 0;

  ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with SingleTickerProviderStateMixin {
  List<Widget> childList = [];
  final TextEditingController txtController = TextEditingController();
  String hintText = "Insert text here to start getting recommendations...";
  bool startedConversation = false;
  int? sessionId;
  bool blocked = false;

  @override
  Widget build(BuildContext context) {
    if (!startedConversation) {
      addChat([
        AnswerField("Hey, welcome! aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
      ]);
      startedConversation = true;
    }

    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: inputHeight),
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width / 17,
                MediaQuery.of(context).size.height / 10,
                MediaQuery.of(context).size.width / 17,
                inputHeight),
            children: childList,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 85,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, sqrt(inputHeight) / 50 + inputHeight * 0.1),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width - 300,
                height: inputHeight,
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    onSubmitted: submitText,
                    controller: txtController,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Lato",
                        decoration: TextDecoration.none,
                        fontSize: FontSizes.flexibleEESmall(context)),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.flexibleEESmall(context)),
                        filled: true,
                        fillColor: Colors.transparent),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                width: 100,
                height: inputHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: MaterialButton(
                        onPressed: () {
                          submitText(txtController.text);
                        },
                        child: Text(
                          sessionId?.toString() ?? "Submit",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Lato",
                              decoration: TextDecoration.none,
                              fontSize: FontSizes.flexibleEESmall(context)),
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
      ],
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

  void submitText(String text) {
    if (blocked) {
      return;
    }
    if (text == "") {
      setState(() {
        hintText = "Can't submit empty message ...";
      });
      return;
    }
    txtController.clear();
    hintText = "Insert text here to start getting recommendations...";
    addChat([
      QuestionText(text),
    ]);
    getTextResponse(text);
  }

  void getTextResponse(String t) async {
    MessageDto? response = await ReqController.postResponse(MessageDto(t, sessionId));
    await Future.delayed(const Duration(milliseconds: 1000));
    if(response == null) {
      addChat([AnswerField("There seems to have been a problem, please repeat your answer")]);
      return;
    }
    setState(() {
      sessionId = response.sessionId;
    });
    addChat([AnswerField(response.text)]);
  }

  int getCount() {
    int tmp = widget.count;
    widget.count += 1;
    return tmp;
  }
}

class AnswerField extends StatefulWidget {
  String answerText;

  AnswerField(this.answerText, {super.key});

  @override
  State<AnswerField> createState() => _AnswerFieldState();
}

class _AnswerFieldState extends State<AnswerField> {
  final fieldText = TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    if (!sent) {
      Timer(const Duration(microseconds: 500), () {
        if (mounted) {
          setState(() {
            sent = true;
          });
        }
      });
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Flexible(
          child: ChatMessage(
            child: Text(
              widget.answerText,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Lato",
                  decoration: TextDecoration.none,
                  fontSize: FontSizes.flexibleNormal(context)),
            ),
          ),
        ),
        Visibility(
            visible: sent,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 100, 0, 0, 0),
              child: Icon(
                Icons.done_all,
                color: const Color.fromARGB(255, 236, 240, 241),
                size: MediaQuery.of(context).size.width / 60,
              ),
            )),
      ]),
    );
  }
}

// ignore: must_be_immutable
class QuestionText extends StatefulWidget {
  String questionText;

  QuestionText(this.questionText, {super.key});

  @override
  State<QuestionText> createState() => _QuestionTextState();
}

class _QuestionTextState extends State<QuestionText> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ChatMessage(
        child: Text(
          widget.questionText,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Lato",
              decoration: TextDecoration.none,
              fontSize: FontSizes.flexibleNormal(context)),
        ),
      ),
    );
  }
}
