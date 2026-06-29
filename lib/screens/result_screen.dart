import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';
import '../services/api_service.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  String getGrade() {
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

  Color getGradeColor() {
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

  IconData getGradeIcon() {
    if (score >= 80) {
      return Icons.emoji_events;
    } else if (score >= 60) {
      return Icons.thumb_up;
    } else if (score >= 40) {
      return Icons.school;
    } else {
      return Icons.menu_book;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hasil Quiz"),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),

            child: Card(
              elevation: 4,

              child: Padding(
                padding: const EdgeInsets.all(30),

                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: getGradeColor() .withValues(alpha: 0.15),

                      child: Icon(
                        getGradeIcon(),
                        size: 55,
                        color: getGradeColor(),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Quiz Selesai",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Selamat! Berikut hasil yang kamu peroleh.",
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Skor",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$score",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: getGradeColor(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),

                      decoration: BoxDecoration(
                        color: getGradeColor() .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Text(
                        getGrade(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: getGradeColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text("Kembali ke Home"),

                        onPressed: () async {
                          await ApiService.updateProgress(score);

                          if (!context.mounted) return;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text("Ulangi Quiz"),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuizScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
