enum ApiErrorType {
  none,
  networkError,
  unauthorized,
  badRequest,
  notFound,
  serverError,
  timeout,
  unknownError,
  emailRegistered,
  emailOrPassowordIcorrect,
  parseError,
  rolNotAccess,
  elementNotFound,
  readMsg,
  passwordIsNotStron
}

extension ApiErrorTypeExtension on ApiErrorType {
  String get message {
    switch (this) {
      case ApiErrorType.networkError:
        return 'Error de red. Por favor verifica tu conexión a internet e intenta nuevamente.';
      case ApiErrorType.unauthorized:
        return 'No autorizado. Por favor inicia sesión o verifica tus credenciales.';
      case ApiErrorType.badRequest:
        return 'Solicitud incorrecta. Por favor verifica los datos ingresados e intenta nuevamente.';
      case ApiErrorType.notFound:
        return 'Recurso no encontrado. Por favor intenta nuevamente.';
      case ApiErrorType.serverError:
        return 'Error interno del servidor. Por favor intenta nuevamente más tarde.';
      case ApiErrorType.timeout:
        return 'Tiempo de espera agotado. Por favor intenta nuevamente más tarde.';
      case ApiErrorType.emailRegistered:
        return 'El correo ya está registrado';
      case ApiErrorType.emailOrPassowordIcorrect:
        return 'Contraseña o correo incorrectos, por favor verifique';
      case ApiErrorType.unknownError:
        return 'Ocurrió un error inesperado. Por favor intenta nuevamente más tarde.';
      case ApiErrorType.parseError:
        return 'Error en el parseo de la data';
      case ApiErrorType.rolNotAccess:
        return 'No tienes el rol necesario para realizar esta acción';
      case ApiErrorType.elementNotFound:
        return 'Elemento no encontrado';
      case ApiErrorType.readMsg:
        return 'Leer mensaje del bakcend';
      case ApiErrorType.passwordIsNotStron:
        return 'La contraseña no es segura';
      default:
        return 'Error desconocido.';
    }
  }
}
