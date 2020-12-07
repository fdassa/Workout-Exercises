import 'package:http/http.dart' as http;

class BaseBloc {
  final http.Client httpClient = http.Client();
}