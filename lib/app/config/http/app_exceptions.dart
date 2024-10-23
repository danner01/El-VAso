class AppException implements Exception {}

class BadRequestException extends AppException {}

class FetchDataException extends AppException {}

class ApiNotRespondingException extends AppException {}

class UnAuthorizedException extends AppException {}
