import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:workout_exercises/blocs/ExerciseDetailsBloc.dart';
import 'package:workout_exercises/models/Equipment.dart';
import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImage.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/models/Muscles.dart';
import 'package:workout_exercises/pages/BasePageState.dart';

class ExercisesDetailsPage extends StatefulWidget {
  ExercisesDetailsPage({@required this.exerciseId});

  final int exerciseId;

  @override
  _ExercisesDetailsPageState createState() => _ExercisesDetailsPageState();
}

class _ExercisesDetailsPageState extends BasePageState<ExercisesDetailsPage> {
  ExerciseDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = ExerciseDetailsBloc(widget.exerciseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Exercise Details'),
        ),
        body: Container(
            child: StreamBuilder<ExerciseDetails>(
          stream: _bloc.detailsStream,
          initialData: null,
          builder:
              (BuildContext context, AsyncSnapshot<ExerciseDetails> snapshot) {
            if (snapshot.hasData) {
              return _onSuccess(snapshot.data);
            } else if (snapshot.hasError) {
              return onError();
            } else {
              return onLoading();
            }
          },
        )));
  }

  Widget _onSuccess(ExerciseDetails exerciseDetails) {
    return ListView(
      children: [
        StreamBuilder<ExerciseImagesResponse>(
          stream: _bloc.imageStream,
          initialData: null,
          builder: (BuildContext context,
              AsyncSnapshot<ExerciseImagesResponse> snapshot) {
            if (snapshot.hasData) {
              return Row(children: _buildImageList(snapshot.data.images));
            } else {
              return Container();
            }
          },
        ),
        Row(children: [
          Flexible(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(exerciseDetails.name,
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
                  child: Text(exerciseDetails.category.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).accentColor)))),
        ]),
        Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Html(
                data: exerciseDetails.description,
                defaultTextStyle: Theme.of(context).textTheme.bodyText1)),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (exerciseDetails.mainMuscles.isNotEmpty)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _buildMainMuscles(exerciseDetails.mainMuscles)))),
          if (exerciseDetails.secondaryMuscles.isNotEmpty)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildSecondaryMuscles(
                            exerciseDetails.secondaryMuscles)))),
        ]),
        if (exerciseDetails.equipments.isNotEmpty)
          _buildEquipments(exerciseDetails.equipments)
      ],
    );
  }

  List<Widget> _buildImageList(List<ExerciseImage> images) {
    final List<Widget> widgetList = List.empty(growable: true);
    images.forEach((image) {
      widgetList.add(Flexible(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Image.network(image.url)))));
    });
    return widgetList;
  }

  List<Widget> _buildMainMuscles(List<Muscles> mainMuscles) {
    final List<Widget> widgetList = List.empty(growable: true);
    widgetList.add(
        Text("Primary muscles", style: Theme.of(context).textTheme.subtitle2));
    mainMuscles.forEach((muscle) {
      widgetList
          .add(Text(muscle.name, style: Theme.of(context).textTheme.bodyText1));
    });
    return widgetList;
  }

  List<Widget> _buildSecondaryMuscles(List<Muscles> secondaryMuscles) {
    final List<Widget> widgetList = List.empty(growable: true);
    widgetList.add(Text("Secondary muscles",
        style: Theme.of(context).textTheme.subtitle2));
    secondaryMuscles.forEach((muscle) {
      widgetList
          .add(Text(muscle.name, style: Theme.of(context).textTheme.bodyText1));
    });
    return widgetList;
  }

  Widget _buildEquipments(List<Equipment> equipments) {
    var equipmentHtml = "<b>Equipments:</b> ";
    equipments.forEach((equipment) {
      equipmentHtml = "$equipmentHtml ${equipment.name},";
    });
    equipmentHtml = equipmentHtml.substring(0, equipmentHtml.length - 1);
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Html(
            data: equipmentHtml,
            defaultTextStyle: Theme.of(context).textTheme.bodyText1));
  }
}
