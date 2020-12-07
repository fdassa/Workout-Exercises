import 'package:http/http.dart' as http;
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

class BaseBloc {
  final http.Client httpClient = http.Client();
}