class HistoryModel {
  final int score;
  final String date;

  HistoryModel({required this.score, required this.date});

  Map<String, dynamic> toJson() {
    return {"score": score, "date": date};
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(score: json["score"], date: json["date"]);
  }
}
