import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

class CategoriesBloc {
  Stream<CategoryListResponse> stream;

  CategoriesBloc() {
    stream = new Stream.fromFuture(fetchCategories());
  }
}