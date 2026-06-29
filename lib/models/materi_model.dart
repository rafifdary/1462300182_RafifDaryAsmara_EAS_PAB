class MateriModel {
  final int id;
  final String title;
  final String body;

  MateriModel({required this.id, required this.title, required this.body});

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
