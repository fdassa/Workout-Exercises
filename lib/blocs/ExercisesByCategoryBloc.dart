import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

class ExercisesByCategoryBloc {
  Stream<ExerciseListResponse> stream;

  ExercisesByCategoryBloc(int categoryId) {
    stream = new Stream.fromFuture(fetchFirstPageExercisesList(categoryId));
  }
}