import 'api_error.dart';

class BdError implements CommonError {
  @override
  final String? errorMsg;

  const BdError({this.errorMsg});
}