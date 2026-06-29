class QuestionModel {
  final String question;
  final List<String> options;
  final int answerIndex;

  const QuestionModel({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}