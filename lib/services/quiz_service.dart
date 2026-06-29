import '../models/question_model.dart';

class QuizService {
  QuizService._();

  static List<QuestionModel> questions = [
    const QuestionModel(
      question: "Apa kepanjangan dari HTML?",
      options: [
        "Hyper Text Markup Language",
        "High Text Machine Language",
        "Home Tool Markup Language",
        "Hyper Transfer Markup Language",
      ],
      answerIndex: 0,
    ),

    const QuestionModel(
      question: "Flutter dikembangkan oleh?",
      options: ["Apple", "Microsoft", "Google", "Meta"],
      answerIndex: 2,
    ),

    const QuestionModel(
      question: "Bahasa utama Flutter adalah...",
      options: ["Java", "Kotlin", "Dart", "Swift"],
      answerIndex: 2,
    ),

    const QuestionModel(
      question: "Widget utama pada Flutter adalah...",
      options: ["Component", "Widget", "Activity", "Fragment"],
      answerIndex: 1,
    ),

    const QuestionModel(
      question: "Firebase Authentication digunakan untuk...",
      options: [
        "Menyimpan gambar",
        "Login dan Register",
        "Membuat API",
        "Mengelola CSS",
      ],
      answerIndex: 1,
    ),
  ];
}
