import 'dart:convert';

SpotifyError spotifyErrorFromJson(String str) =>
    SpotifyError.fromJson(json.decode(str));

String spotifyErrorToJson(SpotifyError data) => json.encode(data.toJson());

class SpotifyError {
  SpotifyError({
    this.error,
  });

  Error error;

  factory SpotifyError.fromJson(Map<String, dynamic> json) => SpotifyError(
        error: Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error.toJson(),
      };
}

class Error {
  Error({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
