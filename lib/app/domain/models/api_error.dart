
import 'package:el_vaso/utilities/enums/api_error_enum.dart';

class ApiError implements CommonError {
  final ApiErrorType apiErrorType;
  @override
  final String? errorMsg;

  const ApiError({this.apiErrorType = ApiErrorType.none, this.errorMsg});
}

abstract class CommonError {
  String? get errorMsg;
}
