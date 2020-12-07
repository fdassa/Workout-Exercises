import 'package:http/http.dart' as http;
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';

import 'BaseBloc.dart';

class CategoriesBloc extends BaseBloc {
  Stream<CategoryListResponse> stream;

  CategoriesBloc() {
    stream = new Stream.fromFuture(fetchCategories(httpClient));
  }
}