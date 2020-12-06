import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

class ExerciseDetailsBloc {
  Stream<ExerciseDetails> detailsStream;
  Stream<ExerciseImagesResponse> imageStream;

  ExerciseDetailsBloc(int exerciseId) {
    detailsStream = new Stream.fromFuture(fetchExerciseDetailsById(exerciseId));
    imageStream = new Stream.fromFuture(fetchExerciseImagesUrlById(exerciseId));
  }
}