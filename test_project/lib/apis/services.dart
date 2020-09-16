import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_project/apis/error.dart';
import 'package:test_project/models/album_details.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:test_project/models/spotify_error.dart';
import 'constants.dart';

abstract class SpotifyRepo {
  Future<AlbumsList> getAlbumsList();
  Future<AlbumDetails> getAlbumDetails(id);
}

class SpotifyAlbumServices implements SpotifyRepo {
  //
  static const _baseUrl = 'api.spotify.com';
  static const String _GET_ALBUMS = '/v1/albums';

  @override
  Future<AlbumsList> getAlbumsList() async {
    Map<String, String> parameters = {
      'ids': ids,
      'market': 'ES',
    };
    Uri uri = Uri.https(_baseUrl, _GET_ALBUMS, parameters);
    Response response = await http.get(uri, headers: headers());
    try {
      AlbumsList albumsList = albumsListFromJson(response.body);
      return albumsList;
    } catch (e) {
      SpotifyError spotifyError = spotifyErrorFromJson(response.body);
      throw SpotifyException(spotifyError);
    }
  }

  static Map<String, String> headers() {
    return {
      'Accept': 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $AUTH_TOKEN',
    };
  }

  @override
  Future<AlbumDetails> getAlbumDetails(id) async {
    String part = '$_GET_ALBUMS/$id';
    Uri uri = Uri.https(_baseUrl, part);
    Response response = await http.get(uri, headers: headers());
    try {
      AlbumDetails albumDetails = albumDetailsFromJson(response.body);
      print(response.body);
      return albumDetails;
    } catch (e) {
      SpotifyError spotifyError = spotifyErrorFromJson(e.error);
      throw SpotifyException(spotifyError);
    }
  }
}
