class Exercise {
  final int id;
  final String name;
  final String description;
  final String author;

  Exercise({this.id, this.name, this.description, this.author});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        author: json['license_author']);
  }
}
