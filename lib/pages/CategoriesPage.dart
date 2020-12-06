import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_exercises/blocs/CategoriesBloc.dart';
import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/pages/ExercisesByCategoryPage.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends BasePageState<CategoriesPage> {
  CategoriesBloc _bloc = CategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
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
}
