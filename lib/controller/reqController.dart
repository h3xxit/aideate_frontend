import 'dart:convert';

import 'package:watchat_ui/common/textReqResponse.dart';
import 'package:http/http.dart' as http;

class ReqController {
  //static String apiURL = "https://watchat-backend.herokuapp.com";
  static String apiURL = "https://aideate.herokuapp.com";

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
}
