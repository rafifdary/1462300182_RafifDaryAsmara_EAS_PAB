import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/history_model.dart';

class HistoryService {
  HistoryService._();

  static const String historyKey = "quiz_history";

  static Future<List<HistoryModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(historyKey) ?? [];

    return data
        .map((e) => HistoryModel.fromJson(jsonDecode(e)))
        .toList()
        .reversed
        .toList();
  }

  static Future<void> saveHistory(HistoryModel history) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(historyKey) ?? [];

    data.add(jsonEncode(history.toJson()));

    await prefs.setStringList(historyKey, data);
  }

  static Future<void> deleteHistory(HistoryModel history) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(historyKey) ?? [];

    data.remove(jsonEncode(history.toJson()));

    await prefs.setStringList(historyKey, data);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(historyKey);
  }
}
