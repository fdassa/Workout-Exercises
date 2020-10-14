class ExerciseImage {
  final int id;
  final String url;

  ExerciseImage({this.id, this.url});

  factory ExerciseImage.fromJson(Map<String, dynamic> json) {
    return ExerciseImage(id: json['id'], url: json['image']);
  }
}
