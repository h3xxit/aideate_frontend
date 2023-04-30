import 'dart:convert';

import 'package:watchat_ui/common/ConversationMessage.dart';
import 'package:watchat_ui/common/MessageDto.dart';
import 'package:http/http.dart' as http;
import 'package:watchat_ui/common/Solution.dart';

class ReqController {
  //static String apiURL = "http://localhost:8080";
  static String apiURL = "https://aideate.herokuapp.com";

  static Future<MessageDto?> initConsultant() async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiURL/init-consultant'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      dynamic res =
      json.decode(const Utf8Decoder().convert(response.bodyBytes));

      return MessageDto(res["text"], res["sessionId"]);
    } else {
      return null;
    }
  }

  static Future<MessageDto?> postResponse(MessageDto messageDto) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse('$apiURL/send-message'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(<String, dynamic>{"text": messageDto.text, "sessionId": messageDto.sessionId}));
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      dynamic res =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));

      return MessageDto(res["text"], res["sessionId"]);
    } else {
      return null;
    }
  }

  static Future<Solution?> getSolution(int sessionId) async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiURL/generate-solution?sessionId=$sessionId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      dynamic res; 
      try{
      res =
      json.decode(const Utf8Decoder().convert(response.bodyBytes));
      }catch (e){
        return Solution("Something went wrong", "Error", "Error" , "Error", "Error");
      }
      return Solution(res["problem"] , res["description"] , res["analysis"] , res["risks"] , res["data"] );
    } else {
      return null;
    }
  }

  static Future<int?> getRating(int sessionId) async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiURL/rate-answer?sessionId=$sessionId'),
          headers: <String, String>{
            'Content-Type': 'text/plain',
          });
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      return int.parse(const Utf8Decoder().convert(response.bodyBytes));
    } else {
      return null;
    }
  }

  static Future<double?> getAvgRating(int sessionId) async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiURL/get-average?sessionId=$sessionId'),
          headers: <String, String>{
            'Content-Type': 'text/plain',
          });
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      return double.parse(const Utf8Decoder().convert(response.bodyBytes));
    } else {
      return null;
    }
  }

  static Future<List<ConversationMessage>?> restoreConversation(int sessionId) async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiURL/restore-session?sessionId=$sessionId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
    } catch (e) {
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      dynamic res =
        json.decode(const Utf8Decoder().convert(response.bodyBytes));

      List<ConversationMessage> list = [];
      for(dynamic entry in res){
        list.add(ConversationMessage(entry["content"], entry["role"]));
      }
      return list;
    } else {
      return null;
    }
  }
}
