import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchat_ui/common/MessageDto.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/design/fontSizes.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';

import 'common/ConversationMessage.dart';

class ChatListView extends StatefulWidget {
  final int? sessionId;
  int count = 0;
  final void Function(int) changeSessionId;
  final void Function(void Function(int?)) setReloadFunction;

  ChatListView(this.sessionId, this.changeSessionId, this.setReloadFunction, {super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    with SingleTickerProviderStateMixin {
  List<Widget> childList = [];
  final TextEditingController txtController = TextEditingController();
  String hintText = "Insert text here to start getting recommendations...";
  bool blocked = false;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    widget.setReloadFunction(refreshChat);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sessionId == null) {
      print("Initialized consultant");
      initializeConsultant();
      initialized = true;
    } else if(initialized == false){
      print("Called refresh");
      refreshChat(widget.sessionId);
      initialized = true;
    }

    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: inputHeight + 55),
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(60, 60, 60, 40),
            children: List<Widget>.of(blocked ? [AnswerField("...")] : []) +
                childList,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 60,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                width: MediaQuery.of(context).size.width * 0.55 - 230,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 50,
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
                          fillColor: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 50),
                width: 100,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 50,
                    child: MaterialButton(
                      color: Colors.white,
                      onPressed: () {
                        submitText(txtController.text);
                      },
                      child: Text(
                        widget.sessionId?.toString() ?? "Submit",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Lato",
                            decoration: TextDecoration.none,
                            fontSize: FontSizes.flexibleEESmall(context)),
                      ),
                    ),
                  ),
                ),
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

  void refreshChat(int? sessionId) async {
    if(sessionId == null) return;
    List<ConversationMessage>? history = await ReqController.restoreConversation(sessionId!);
    if(history == null) return;
    print(history.length);
    setState(() {
      childList.clear();
    });
    for(ConversationMessage msg in history){
      if(!msg.text.startsWith("Using the above information collected about the business, export the use case where AI can be applied that you think would ")){
        if(!msg.text.startsWith("{")){
        if(msg.role == "user"){
          addChat([QuestionText(msg.text)]);
        } else {
          addChat([AnswerField(msg.text)]);
        }
        }
      }
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

  void initializeConsultant() async {
    if (blocked) {
      return;
    }
    setState(() {
      blocked = true;
    });
    try {
      MessageDto? response = await ReqController.initConsultant();
      await Future.delayed(const Duration(milliseconds: 1000));
      if (response == null) {
        addChat([
          AnswerField(
              "There seems to have been a problem, please refresh the page")
        ]);
        setState(() {
          blocked = false;
        });
        return;
      }
      widget.changeSessionId(response.sessionId);
      addChat([AnswerField(response.text)]);
    } on Exception catch (_) {
    } finally {
      setState(() {
        blocked = false;
      });
    }
  }

  void getTextResponse(String t) async {
    try {
      if (widget.sessionId == null) {
        initializeConsultant();
      }
      setState(() {
        blocked = true;
      });
      MessageDto? response =
          await ReqController.postResponse(MessageDto(t, widget.sessionId!));
      await Future.delayed(const Duration(milliseconds: 1000));
      if (response == null) {
        addChat([
          AnswerField("There seems to have been a problem, please repeat your answer")
        ]);
        setState(() {
          blocked = false;
        });
        return;
      }
      widget.changeSessionId(response.sessionId);
      addChat([AnswerField(response.text)]);
    } on Exception catch (_) {
    } finally {
      setState(() {
        blocked = false;
      });
    }
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
            isAi: true,
            child: Text(
              widget.answerText,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Lato",
                  decoration: TextDecoration.none,
                  fontSize: 20),
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
        isAi: false,
        child: Text(
          widget.questionText,
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