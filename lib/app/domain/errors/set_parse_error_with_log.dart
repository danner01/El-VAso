import 'dart:developer';


import 'package:el_vaso/utilities/enums/api_error_enum.dart';

import '../models/api_error.dart';

ApiError setParseErrorWithLog(dynamic e, StackTrace s) {
  log('Parse error: $e');
  log('StackTrace: $s', level: 0);
  return ApiError(
    apiErrorType: ApiErrorType.parseError,
    errorMsg: 'Parse error: $e',
  );
}
