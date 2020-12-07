// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:workout_exercises/models/CategoryListResponse.dart';
import 'package:workout_exercises/models/ExerciseDetails.dart';
import 'package:workout_exercises/models/ExerciseImagesResponse.dart';
import 'package:workout_exercises/models/ExerciseListResponse.dart';
import 'package:workout_exercises/repository/Repository.dart';
import 'package:workout_exercises/repository/UrlProvider.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchCategories', () {
    test('returns a list of Category if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(CATEGORIES_URL))
          .thenAnswer((_) async => http.Response('{"results": [{"id": 8, "name": "Arms"}, {"id": 10, "name": "Abs"}, {"id": 11, "name": "Chest"}]}', 200));

      expect(await fetchCategories(client), isA<CategoryListResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(CATEGORIES_URL))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchCategories(client), throwsException);
    });
  });

  group('fetchFirstPageExercisesList', () {
    test('returns a list of Exercises if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(exercisesByCategoryUrl(8)))
          .thenAnswer((_) async => http.Response('{"count":44,"next":null,"previous":null,"results":[{"id":289,"license_author":"GrosseHund","description":"<p>Grab dumbbells and extend arms to side and hold as long as you can</p>","name":"Axe Hold"}]}', 200));

      expect(await fetchFirstPageExercisesList(client, 8), isA<ExerciseListResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(exercisesByCategoryUrl(8)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchFirstPageExercisesList(client, 8), throwsException);
    });
  });

  group('fetchExerciseDetailsById', () {
    test('returns the Exercises Details if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(exerciseDetailsById(88)))
          .thenAnswer((_) async => http.Response('{"id":88,"name":"Bench Press Narrow Grip","category":{"id":8,"name":"Arms"},"description":"<p>Lay down on a bench, the bar is directly over your eyes, the knees form a slight angle and the feet are firmly on the ground. Hold the bar with a narrow grip (around 20cm.). Lead the weight slowly down till the arms are parallel to the floor (elbow: right angle), press then the bar up.</p>","muscles":[{"id":5,"name":"Triceps brachii","is_front":false}],"muscles_secondary":[{"id":2,"name":"Anterior deltoid","is_front":true},{"id":4,"name":"Pectoralis major","is_front":true}],"equipment":[{"id":1,"name":"Barbell"},{"id":8,"name":"Bench"}],"language":{"id":2,"short_name":"en","full_name":"English"},"license":{"id":1,"full_name":" Creative Commons Attribution Share Alike 3","short_name":"CC-BY-SA 3","url":"https://creativecommons.org/licenses/by-sa/3.0/deed.en"},"license_author":"wger.de","images":[{"id":15,"license_author":"Everkinetic","status":"2","image":"https://wger.de/media/exercise-images/88/Narrow-grip-bench-press-1.png","is_main":true,"license":1,"exercise":88},{"id":16,"license_author":"Everkinetic","status":"2","image":"https://wger.de/media/exercise-images/88/Narrow-grip-bench-press-2.png","is_main":false,"license":1,"exercise":88}]}', 200));

      expect(await fetchExerciseDetailsById(client, 88), isA<ExerciseDetails>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(exerciseDetailsById(88)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchExerciseDetailsById(client, 88), throwsException);
    });
  });

  group('fetchExerciseImagesUrlById', () {
    test('returns a list of url for the Images of the Exercise if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(exerciseImageById(74)))
          .thenAnswer((_) async => http.Response('{"results":[{"id":27,"image":"https://wger.de/media/exercise-images/74/Bicep-curls-1.png"}]}', 200));

      expect(await fetchExerciseImagesUrlById(client, 74), isA<ExerciseImagesResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(exerciseImageById(74)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchExerciseImagesUrlById(client, 74), throwsException);
    });
  });
}
