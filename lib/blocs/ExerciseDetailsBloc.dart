import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

import 'BaseBloc.dart';

class ExerciseDetailsBloc extends BaseBloc {
  Stream<ExerciseDetails> detailsStream;
  Stream<ExerciseImagesResponse> imageStream;

  ExerciseDetailsBloc(int exerciseId) {
    detailsStream = new Stream.fromFuture(fetchExerciseDetailsById(httpClient, exerciseId));
    imageStream = new Stream.fromFuture(fetchExerciseImagesUrlById(httpClient, exerciseId));
  }
}