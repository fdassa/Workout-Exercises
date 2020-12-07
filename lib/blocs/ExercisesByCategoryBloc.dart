import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

import 'BaseBloc.dart';

class ExercisesByCategoryBloc extends BaseBloc {
  Stream<ExerciseListResponse> stream;

  ExercisesByCategoryBloc(int categoryId) {
    stream = new Stream.fromFuture(fetchFirstPageExercisesList(httpClient, categoryId));
  }
}