import 'package:http/http.dart';

import '../models/api_error.dart';
import 'get_error_from_response.dart';
import 'get_error_from_status_code.dart';

ApiError getApiError(Response response) {
  return ApiError(
      apiErrorType: getErrorFromStatusCode(response.statusCode),
      errorMsg: getErrorFromResponse(response));
}
