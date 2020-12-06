import 'package:flutter/material.dart';
import 'package:workout_exercises/blocs/ExercisesByCategoryBloc.dart';
import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/Exercise.dart';
import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/pages/ExercisesDetailsPage.dart';

class ExercisesByCategoryPage extends StatefulWidget {
  ExercisesByCategoryPage({@required this.category});

  final Category category;

  @override
  _ExercisesByCategoryPageState createState() =>
      _ExercisesByCategoryPageState();
}

class _ExercisesByCategoryPageState extends BasePageState<ExercisesByCategoryPage> {
  ExercisesByCategoryBloc _bloc;

  @override
  void initState() {
    _bloc = ExercisesByCategoryBloc(widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.category.name} Exercises'),
        ),
        body: Container(
            child: StreamBuilder<ExerciseListResponse>(
              stream: _bloc.stream,
              initialData: null,
              builder: (BuildContext context,
                  AsyncSnapshot<ExerciseListResponse> snapshot) {
                if (snapshot.hasData) {
                  return _onSuccess(snapshot.data.exercises);
                } else if (snapshot.hasError) {
                  return onError();
                } else {
                  return onLoading();
                }
              },
            )));
  }

  Widget _onSuccess(List<Exercise> exercises) {
    return ListView.separated(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final Exercise exercise = exercises[index];
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

  void _handleItemClick(int exerciseId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExercisesDetailsPage(exerciseId: exerciseId)),
    );
  }
}
