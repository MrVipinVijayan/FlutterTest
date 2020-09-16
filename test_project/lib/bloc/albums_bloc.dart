import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:test_project/apis/error.dart';
import 'package:test_project/apis/services.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/models/spotify_error.dart';

@immutable
abstract class SpotifyState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends SpotifyState {
  //
}

class AlbumsLoading extends SpotifyState {
  //
}

class AlbumsLoaded extends SpotifyState {
  final AlbumsList albumsList;
  AlbumsLoaded(this.albumsList);
}

class AlbumListError extends SpotifyState {
  final error;
  AlbumListError({this.error});
}

class SpotifyBloc extends Bloc<SpotifyEvents, SpotifyState> {
  //
  final SpotifyRepo spotifyRepo;
  AlbumsList albumsList;

  SpotifyBloc({this.spotifyRepo}) : super(AlbumsInitState());

  @override
  Stream<SpotifyState> mapEventToState(SpotifyEvents event) async* {
    switch (event) {
      case SpotifyEvents.fetchAlbums:
        yield AlbumsLoading();
        try {
          if (null == albumsList) {
            albumsList = await spotifyRepo.getAlbumsList();
          }
          yield AlbumsLoaded(albumsList);
        } on SocketException {
          yield AlbumListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield AlbumListError(
            error: NoInternetException('No Service Found.'),
          );
        } on FormatException {
          yield AlbumListError(
            error: InvalidFormatException('Parse Error'),
          );
        } on SpotifyException catch (e) {
          SpotifyError spotifyError = e.error;
          yield AlbumListError(
            error: UnknownException(spotifyError.error.message),
          );
        } catch (e) {
          yield AlbumListError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
    }
  }
}

enum SpotifyEvents {
  fetchAlbums,
}
