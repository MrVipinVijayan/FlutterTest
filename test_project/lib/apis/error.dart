class NoInternetException {
  var message;
  NoInternetException(this.message);
}

class NoServiceFoundException {
  var message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  var message;
  InvalidFormatException(this.message);
}

class UnknownException {
  String message;
  UnknownException(this.message);
}

class SpotifyException {
  var error;
  SpotifyException(this.error);
}
