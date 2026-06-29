import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/question_model.dart';
import '../services/api_service.dart';
import '../services/quiz_service.dart';
import '../utils/app_colors.dart';
import 'result_screen.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';
import '../services/notification_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuestionModel> questions = QuizService.questions;

  int currentQuestion = 0;

  int? selectedAnswer;

  int score = 0;

  bool isLoading = false;

  Future<void> nextQuestion() async {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silakan pilih jawaban terlebih dahulu.")),
      );
      return;
    }

    if (selectedAnswer == questions[currentQuestion].answerIndex) {
      score += 20;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      await finishQuiz();
    }
  }

  Future<void> finishQuiz() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("last_score", score);

    await HistoryService.saveHistory(
      HistoryModel(score: score, date: DateTime.now().toString()),
    );

    await ApiService.submitQuiz(score: score);

    await NotificationService.showNotification(
      title: "Quiz Selesai 🎉",
      body: "Selamat! Kamu memperoleh skor $score.",
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ResultScreen(score: score)),
    );

    setState(() {
      isLoading = false;
    });
  }

  Widget buildOption(String option, int index) {
    final bool selected = selectedAnswer == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        margin: const EdgeInsets.only(bottom: 15),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),

        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: selected ? Colors.white : AppColors.primary,

              child: Text(
                String.fromCharCode(65 + index),
                style: TextStyle(
                  color: selected ? AppColors.primary : Colors.white,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.white : Colors.black87,

                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    final progress = (currentQuestion + 1) / questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Quiz"), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Soal ${currentQuestion + 1} dari ${questions.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: progress, minHeight: 10),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Pertanyaan",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    return buildOption(question.options[index], index);
                  },
                ),
              ),

              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : nextQuestion,
                  icon: Icon(
                    currentQuestion == questions.length - 1
                        ? Icons.check_circle
                        : Icons.arrow_forward,
                  ),
                  label: Text(
                    currentQuestion == questions.length - 1
                        ? "Selesai"
                        : "Soal Berikutnya",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
