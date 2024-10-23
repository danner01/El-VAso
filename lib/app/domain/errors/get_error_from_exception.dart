import 'package:el_vaso/utilities/enums/api_error_enum.dart';

import '../../config/http/app_exceptions.dart';

import '../models/api_error.dart';

ApiError getErrorFromException(Object error) {
  if (error is BadRequestException) {
    return const ApiError(
      apiErrorType: ApiErrorType.networkError,
      errorMsg:
          'Ocurrió un problema con la conexión a internet. Intente de nuevo',
    );
  } else if (error is FetchDataException) {
    return const ApiError(
      apiErrorType: ApiErrorType.timeout,
      errorMsg: 'Tiempo de espera agotado. Intente de nuevo',
    );
  } else if (error is ApiNotRespondingException) {
    return const ApiError(
      apiErrorType: ApiErrorType.timeout,
      errorMsg: 'Tiempo de espera agotado',
    );
  } else {
    return const ApiError(
      apiErrorType: ApiErrorType.unknownError,
      errorMsg: 'Error desconocido',
    );
  }
}
