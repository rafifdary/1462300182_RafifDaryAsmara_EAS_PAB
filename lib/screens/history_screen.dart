import 'package:flutter/material.dart';

import '../models/history_model.dart';
import '../services/history_service.dart';
import '../utils/app_colors.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryModel> histories = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    setState(() {
      isLoading = true;
    });

    histories = await HistoryService.getHistory();

    setState(() {
      isLoading = false;
    });
  }

  String getKategori(int score) {
    if (score >= 80) {
      return "Sangat Baik";
    } else if (score >= 60) {
      return "Baik";
    } else if (score >= 40) {
      return "Cukup";
    } else {
      return "Perlu Belajar Lagi";
    }
  }

  Color getColor(int score) {
    if (score >= 80) {
      return Colors.green;
    } else if (score >= 60) {
      return Colors.blue;
    } else if (score >= 40) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Future<void> deleteItem(int index) async {
    final item = histories[index];

    await ApiService.deleteHistory(item.score);

    await HistoryService.deleteHistory(item);

    await loadHistory();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("History berhasil dihapus")));
  }

  Future<void> clearAll() async {
    await HistoryService.clearHistory();

    await loadHistory();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua history berhasil dihapus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("History Quiz"),
        actions: [
          IconButton(
            onPressed: histories.isEmpty ? null : clearAll,
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: loadHistory,

        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : histories.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 180),
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Belum ada history quiz",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  final item = histories[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: getColor(item.score).withValues(alpha: 0.15),
                        child: Text(
                          "${item.score}",
                          style: TextStyle(
                            color: getColor(item.score),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        "Nilai ${item.score}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getKategori(item.score)),
                          const SizedBox(height: 4),
                          Text(item.date, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteItem(index);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
