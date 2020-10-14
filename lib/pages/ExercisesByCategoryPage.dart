import 'package:flutter/material.dart';
import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/Exercise.dart';
import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/pages/ExercisesDetailsPage.dart';
import 'package:workout_exercises/repository/Repository.dart';

class ExercisesByCategoryPage extends StatefulWidget {
  ExercisesByCategoryPage({@required this.category});

  final Category category;

  @override
  _ExercisesByCategoryPageState createState() =>
      _ExercisesByCategoryPageState();
}

class _ExercisesByCategoryPageState extends BasePageState<ExercisesByCategoryPage> {
  List<Exercise> _exercises;

  @override
  void initState() {
    title = '${widget.category.name} Exercises';
    fetchFirstPageExercisesList(widget.category.id)
        .then((exerciseListResponse) => _updateExercises(exerciseListResponse))
        .catchError((error) => _handleError(error));
    super.initState();
  }

  @override
  Widget onSuccess() {
    return ListView.separated(
      itemCount: _exercises.length,
      itemBuilder: (context, index) {
        final Exercise exercise = _exercises[index];
        return ListTile(
            title: Text(exercise.name),
            subtitle: Text('Posted by: ${exercise.author}'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              _handleItemClick(exercise.id);
            });
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void _updateExercises(ExerciseListResponse exerciseListResponse) {
    setState(() {
      _exercises = exerciseListResponse.exercises;
      requestState = RequestState.success;
    });
  }

  void _handleError(Exception error) {
    setState(() {
      requestState = RequestState.error;
    });
  }

  void _handleItemClick(int exerciseId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExercisesDetailsPage(exerciseId: exerciseId)),
    );
  }
}
