
import 'package:el_vaso/utilities/enums/api_error_enum.dart';

ApiErrorType getErrorFromStatusCode(int statusCode) {
  // switch (statusCode) {
  //   case 400:
  //     return ApiErrorType.badRequest;
  //   case 401:
  //     return ApiErrorType.unauthorized;
  //   case 404:
  //     return ApiErrorType.notFound;
  //   case 409:
  //     return ApiErrorType.emailRegistered;
  //   case 500:
  //     return ApiErrorType.serverError;
  //   default:
  //     return ApiErrorType.unknownError;
  // }
   switch (statusCode) {
    case 400:
      return ApiErrorType.emailRegistered;
    case 401:
      return ApiErrorType.unauthorized;
    case 404:
      return ApiErrorType.readMsg;
    case 409:
      return ApiErrorType.unknownError;
    case 500:
      return ApiErrorType.serverError;
    default:
      return ApiErrorType.unknownError;
  }
}
