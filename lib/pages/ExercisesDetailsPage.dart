import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImage.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/repository/Repository.dart';

class ExercisesDetailsPage extends StatefulWidget {
  ExercisesDetailsPage({@required this.exerciseId});

  final int exerciseId;

  @override
  _ExercisesDetailsPageState createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends BasePageState<ExercisesDetailsPage> {
  ExerciseDetails _exerciseDetails;
  List<ExerciseImage> _images = List.empty();

  @override
  void initState() {
    title = 'Exercise Details';
    fetchExerciseImagesUrlById(widget.exerciseId)
        .then((exercisesImagesResponse) =>
            _updateImagesUrl(exercisesImagesResponse))
        .catchError((error) => _handleError(error));
    fetchExerciseDetailsById(widget.exerciseId)
        .then((exerciseDetails) => _updateExerciseDetails(exerciseDetails))
        .catchError((error) => _handleError(error));
    super.initState();
  }

  @override
  Widget onSuccess() {
    return ListView(
      children: [
        if (_images.isNotEmpty) Row(children: _buildImageList()),
        Row(children: [
          Flexible(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(_exerciseDetails.name,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.subtitle1))),
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
              child: Center(
                  child: Text(_exerciseDetails.category.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).accentColor)))),
        ]),
        Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Html(
                data: _exerciseDetails.description,
                defaultTextStyle: Theme.of(context).textTheme.bodyText1)),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (_exerciseDetails.mainMuscles.isNotEmpty)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildMainMuscles()))),
          if (_exerciseDetails.secondaryMuscles.isNotEmpty)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildSecondaryMuscles()))),
        ]),
        if (_exerciseDetails.equipments.isNotEmpty) _buildEquipments()
      ],
    );
  }

  List<Widget> _buildImageList() {
    final List<Widget> widgetList = List.empty(growable: true);
    _images.forEach((image) {
      widgetList.add(Flexible(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Image.network(image.url)))));
    });
    return widgetList;
  }

  List<Widget> _buildMainMuscles() {
    final List<Widget> widgetList = List.empty(growable: true);
    widgetList.add(
        Text("Primary muscles", style: Theme.of(context).textTheme.subtitle2));
    _exerciseDetails.mainMuscles.forEach((muscle) {
      widgetList
          .add(Text(muscle.name, style: Theme.of(context).textTheme.bodyText1));
    });
    return widgetList;
  }

  List<Widget> _buildSecondaryMuscles() {
    final List<Widget> widgetList = List.empty(growable: true);
    widgetList.add(Text("Secondary muscles",
        style: Theme.of(context).textTheme.subtitle2));
    _exerciseDetails.secondaryMuscles.forEach((muscle) {
      widgetList
          .add(Text(muscle.name, style: Theme.of(context).textTheme.bodyText1));
    });
    return widgetList;
  }

  Widget _buildEquipments() {
    var equipmentHtml = "<b>Equipments:</b> ";
    _exerciseDetails.equipments.forEach((equipment) {
      equipmentHtml = "$equipmentHtml ${equipment.name},";
    });
    equipmentHtml = equipmentHtml.substring(0, equipmentHtml.length - 1);
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Html(
            data: equipmentHtml,
            defaultTextStyle: Theme.of(context).textTheme.bodyText1));
  }

  void _updateExerciseDetails(ExerciseDetails exerciseDetails) {
    setState(() {
      _exerciseDetails = exerciseDetails;
      requestState = RequestState.success;
    });
  }

  void _updateImagesUrl(ExerciseImagesResponse exercisesImagesResponse) {
    setState(() {
      _images = exercisesImagesResponse.images;
    });
  }

  void _handleError(Exception error) {
    setState(() {
      requestState = RequestState.error;
    });
  }
}
