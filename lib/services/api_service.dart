import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/materi_model.dart';

class ApiService {
  ApiService._();

  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  /// =======================
  /// GET Semua Materi
  /// =======================

  static Future<List<MateriModel>> getMateri() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => MateriModel.fromJson(e)).toList();
    }

    throw Exception("Gagal mengambil data.");
  }

  /// =======================
  /// GET Detail Materi
  /// =======================

  static Future<MateriModel> getDetailMateri(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/posts/$id"));

    if (response.statusCode == 200) {
      return MateriModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Data tidak ditemukan.");
  }

  /// =======================
  /// POST (Simulasi Submit Quiz)
  /// =======================

  static Future<bool> submitQuiz({required int score}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/posts"),
      body: {"score": score.toString()},
    );

    return response.statusCode == 201;
  }

  /// =======================
  /// PUT (Simulasi Update)
  /// =======================

  static Future<bool> updateProgress(int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/posts/$id"),
      body: {"progress": "100"},
    );

    return response.statusCode == 200;
  }

  /// =======================
  /// DELETE
  /// =======================

  static Future<bool> deleteHistory(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/posts/$id"));

    return response.statusCode == 200;
  }
}
