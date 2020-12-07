import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workout_exercises/blocs/CategoriesBloc.dart';
import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/pages/ExercisesByCategoryPage.dart';

import '../WorkoutLocalizations.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({@required this.flutterLocalNotificationsPlugin});

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends BasePageState<CategoriesPage> {
  CategoriesBloc _bloc = CategoriesBloc();
  final platform = const MethodChannel('samples.flutter.dev/battery');

  @override
  void initState() {
    _getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(WorkoutLocalizations.of(context).categories),
        ),
        body: Container(
            child: StreamBuilder<CategoryListResponse>(
          stream: _bloc.stream,
          initialData: null,
          builder: (BuildContext context,
              AsyncSnapshot<CategoryListResponse> snapshot) {
            if (snapshot.hasData) {
              return _onSuccess(snapshot.data.categories);
            } else if (snapshot.hasError) {
              return onError();
            } else {
              return onLoading();
            }
          },
        )));
  }

  Widget _onSuccess(List<Category> _categories) {
    return ListView.separated(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final Category category = _categories[index];
        return ListTile(
            leading: CircleAvatar(
              backgroundImage: category.getAssetImage(),
              backgroundColor: Colors.white,
            ),
            contentPadding: EdgeInsets.all(4),
            title: Text(category.name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              _handleItemClick(category);
            });
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void _handleItemClick(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExercisesByCategoryPage(category: category)),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1231213113', 'battery warning',
            'battery warning notification channel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    final localizations = WorkoutLocalizations.of(context);
    await widget.flutterLocalNotificationsPlugin.show(
        0,
        localizations.lowBattery,
        localizations.lowBatteryBody,
        platformChannelSpecifics);
  }

  Future<void> _getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      if (result < 25) {
        _showNotification();
      }
    } on PlatformException catch (e) {}
  }
}
