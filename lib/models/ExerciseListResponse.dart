import 'package:workout_exercises/models/Exercise.dart';

class ExerciseListResponse {
  final int count;
  final String nextPageUrl;
  final String previousPageUrl;
  final List<Exercise> exercises;

  ExerciseListResponse(
      {this.count, this.nextPageUrl, this.previousPageUrl, this.exercises});

  factory ExerciseListResponse.fromJson(Map<String, dynamic> json) {
    return ExerciseListResponse(
        count: json['count'],
        nextPageUrl: json['next'],
        previousPageUrl: json['previous'],
        exercises: (json['results'] as List)
            .map((data) => Exercise.fromJson(data))
            .toList());
  }
}
