// ignore_for_file: unnecessary_this, depend_on_referenced_packages
import 'dart:math';
import 'package:http/http.dart' as http;

class TelegramClient {
  // Variables
  final String chatId;
  final String botToken;

  // Required parameters
  TelegramClient({
    required this.chatId,
    required this.botToken,
  });

  // Text of the message to be sent, 1-4096 characters after entities parsing
  // https://core.telegram.org/bots/api#sendmessage
  String _limitMessage(final String message) =>
      message.substring(0, min(4096, message.length));

  // sendMessage
  Future<http.Response> sendMessage(final String message) {
    final Uri uri = Uri.https(
      "api.telegram.org",
      "/bot${this.botToken}/sendMessage",
      {
        "chat_id": this.chatId,
        "text": _limitMessage(message),
        "parse_mode": "html",
      },
    );
    return http.get(uri);
  }
}
