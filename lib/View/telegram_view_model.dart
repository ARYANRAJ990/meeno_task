import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:js' as js;

import '../Model/tg_user_model.dart';

class TelegramProvider extends ChangeNotifier {
  TgUserModel? _telegramData;

  TgUserModel? get telegramUser => _telegramData;

  Future<void> getTelegramData() async {
    _telegramData = await initTelegramWebApp();
    notifyListeners();
  }

  // Function to initialize the Telegram WebApp
  Future<TgUserModel?> initTelegramWebApp() async {
    final result = await js.context.callMethod('initTelegramWebApp');
    if (result != null) {
      try {
        String jsonStringTesting = '''
            {"user": {"id": 9504676403, "first_name": "Aryan", "last_name": "Raj", "language_code": "en", "allows_write_to_pm": true}, "chat_instance": -6755861448974533654, "chat_type": "sender", "auth_date": "1729235746", "hash": "ea902729a39a94e2ae9a361fb09a577eabb3d7c09f5e2fc5fefa51f75be907c3"}''';
        String jsonString = js.context['JSON'].callMethod('stringify', [result]);
        Map<String, dynamic> telegramData = jsonDecode(jsonStringTesting);
        return TgUserModel.fromMap(telegramData);
      } catch (e) {
        throw ("Error in parsing telegram data: $e");

      }
    }
    return null;
  }

  // Function to send data back to Telegram
  static void sendTelegramData(String data) {
    js.context.callMethod('sendTelegramData', [data]);
  }

  // Function to control the MainButton in Telegram
  static void setMainButton(String text, bool isVisible) {
    js.context.callMethod('setMainButton', [text, isVisible]);
  }
}