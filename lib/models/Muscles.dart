class Muscles {
  final int id;
  final String name;

  Muscles({this.id, this.name});

  factory Muscles.fromJson(Map<String, dynamic> json) {
    return Muscles(
        id: json['id'],
        name: json['name']);
  }
}
