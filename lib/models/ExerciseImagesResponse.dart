import 'package:workout_exercises/models/ExerciseImage.dart';

class ExerciseImagesResponse {
  final List<ExerciseImage> images;

  ExerciseImagesResponse({this.images});

  factory ExerciseImagesResponse.fromJson(Map<String, dynamic> json) {
    return ExerciseImagesResponse(
        images: (json['results'] as List)
            .map((data) => ExerciseImage.fromJson(data))
            .toList());
  }
}
