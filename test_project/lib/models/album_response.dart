import 'package:test_project/models/spotify_error.dart';

import 'albums_list.dart';

class AlbumListReponse {
  AlbumsList albumsList;
  SpotifyError spotifyError;

  setSpotifyError(SpotifyError spotifyError) {
    this.spotifyError = spotifyError;
  }

  setAlbumList(AlbumsList albumsList) {
    this.albumsList = albumsList;
  }

  SpotifyError get error => spotifyError;
}
