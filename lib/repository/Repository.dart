import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/repository/UrlProvider.dart';

Future<CategoryListResponse> fetchCategories() async {
  final response = await _fetch(CATEGORIES_URL);
  if (response.statusCode == 200)
    return CategoryListResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load categories');
}

Future<ExerciseListResponse> fetchFirstPageExercisesList(int categoryId) async {
  final response = await _fetch(exercisesByCategoryUrl(categoryId));
  if (response.statusCode == 200)
    return ExerciseListResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercises');
}

Future<ExerciseDetails> fetchExerciseDetailsById(int exerciseId) async {
  final response = await _fetch(exerciseDetailsById(exerciseId));
  if (response.statusCode == 200)
    return ExerciseDetails.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercise details');
}

Future<ExerciseImagesResponse> fetchExerciseImagesUrlById(int exerciseId) async {
  final response = await _fetch(exerciseImageById(exerciseId));
  if (response.statusCode == 200)
    return ExerciseImagesResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercise images');
}

Future<http.Response> _fetch(String url) {
  return http.get(url);
}
