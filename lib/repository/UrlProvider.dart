const String _BASE_URL = 'https://wger.de/api/v2';
const String CATEGORIES_URL = '$_BASE_URL/exercisecategory.json/';

String exercisesByCategoryUrl(int categoryId) {
  return '$_BASE_URL/exercise.json/?category=$categoryId&language=2&limit=20&status=2';
}

String exerciseDetailsById(int exerciseId) {
  return '$_BASE_URL/exerciseinfo/$exerciseId/?format=json';
}

String exerciseImageById(int exerciseId) {
  return '$_BASE_URL/exerciseimage/?format=json&exercise=$exerciseId&is_main=true';
}
