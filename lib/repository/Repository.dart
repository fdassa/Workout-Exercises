import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/repository/UrlProvider.dart';

Future<CategoryListResponse> fetchCategories(http.Client httpClient) async {
  final response = await httpClient.get(CATEGORIES_URL);
  if (response.statusCode == 200)
    return CategoryListResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load categories');
}

Future<ExerciseListResponse> fetchFirstPageExercisesList(
    http.Client httpClient, int categoryId) async {
  final response = await httpClient.get(exercisesByCategoryUrl(categoryId));
  if (response.statusCode == 200)
    return ExerciseListResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercises');
}

Future<ExerciseDetails> fetchExerciseDetailsById(
    http.Client httpClient, int exerciseId) async {
  final response = await httpClient.get(exerciseDetailsById(exerciseId));
  if (response.statusCode == 200)
    return ExerciseDetails.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercise details');
}

Future<ExerciseImagesResponse> fetchExerciseImagesUrlById(
    http.Client httpClient, int exerciseId) async {
  final response = await httpClient.get(exerciseImageById(exerciseId));
  if (response.statusCode == 200)
    return ExerciseImagesResponse.fromJson(json.decode(response.body));
  else
    throw Exception('Failed to load exercise images');
}
