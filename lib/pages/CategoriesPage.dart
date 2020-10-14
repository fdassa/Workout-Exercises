import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/pages/BasePageState.dart';
import 'package:workout_exercises/pages/ExercisesByCategoryPage.dart';
import 'package:workout_exercises/repository/Repository.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends BasePageState<CategoriesPage> {
  List<Category> _categories;

  @override
  void initState() {
    title = 'Categories';
    fetchCategories()
        .then((exerciseListResponse) => _updateExercises(exerciseListResponse))
        .catchError((error) => _handleError(error));
    super.initState();
  }

  @override
  Widget onSuccess() {
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

  void _updateExercises(CategoryListResponse categoryListResponse) {
    setState(() {
      _categories = categoryListResponse.categories;
      requestState = RequestState.success;
    });
  }

  void _handleError(Exception error) {
    setState(() {
      requestState = RequestState.error;
    });
  }
}
