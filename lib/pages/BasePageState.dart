import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../WorkoutLocalizations.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> {
  Widget onLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget onError() {
    return Center(child: Text(WorkoutLocalizations.of(context).errorMessage));
  }
}
