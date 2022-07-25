import 'dart:convert';
import 'dart:developer' as developer;

class Logger {
  Logger._();

  static const _tag = "lands_and_homes.app";

  static i(dynamic info, {String tag = _tag, bool isJson = false}) {
    developer.log(isJson ? jsonEncode(info) : info, name: tag);
  }

  static e(String message,
      {String tag = _tag, Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: tag, error: error, stackTrace: stackTrace);
  }
}
