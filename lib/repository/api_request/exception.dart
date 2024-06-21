class AuthRequestFailure implements Exception {
  AuthRequestFailure() {
    throw 'Authentication request failed';
  }
}

class JobseekerNotFound implements Exception {
  JobseekerNotFound() {
    throw 'Given user does not exist';
  }
}

class JobseekerCredentialsNotMatch implements Exception {
  JobseekerCredentialsNotMatch() {
    throw 'Check your credentials and try again.';
  }
}

class NetworkConnectionError implements Exception {
  NetworkConnectionError() {
    throw 'Check your internet connection and try again.';
  }
}

class BadRequestError implements Exception {
  BadRequestError() {
    throw 'Check your credentials and try again.';
  }
}

class UnauthorizedError implements Exception {
  UnauthorizedError() {
    throw 'Response code : 401, You are not authorized to make this request.';
  }
}

class ForbiddenError implements Exception {
  ForbiddenError() {
    throw 'Response code : 403, Server denied your request.';
  }
}

class NotFoundError implements Exception {
  NotFoundError() {
    throw 'Response code: 404,the server cannot find the requested resource.';
  }
}

class InternalServerError implements Exception {
  InternalServerError() {
    throw 'Internal Server Error.';
  }
}

class ResponseError implements Exception {
  ResponseError() {
    throw 'Response code <200.';
  }
}
