
import 'package:workout_exercises/models/Category.dart';

class CategoryListResponse {
  final List<Category> categories;

  CategoryListResponse({this.categories});

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
        categories: (json['results'] as List)
            .map((data) => Category.fromJson(data))
            .toList());
  }
}
