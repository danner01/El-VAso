import 'package:http/http.dart';

String getErrorFromResponse(Response response) {
  return 'Status code: ${response.statusCode}\nbody: ${response.body}';
}
