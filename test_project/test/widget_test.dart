import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:test_project/apis/error.dart';
import 'package:test_project/apis/services.dart';
import 'package:test_project/bloc/albums_bloc.dart';
import 'package:test_project/bloc/theme_bloc.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:test_project/screens/albums_screen.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyRepo extends Mock implements SpotifyRepo {}

void main() {
  //
  MockSpotifyRepo mockSpotifyRepo;

  setUp(() {
    mockSpotifyRepo = new MockSpotifyRepo();
  });

  group('Group Test Widget', () {
    testWidgets('Widget Test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        SpotifyBloc spotifyBloc =
            SpotifyBloc(spotifyRepo: SpotifyAlbumServices());
        AlbumsScreen albumsScreen = AlbumsScreen();
        var app = BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (BuildContext context, ThemeState themeState) {
              return MaterialApp(
                theme: themeState.themeData,
                home: BlocProvider(
                  create: (context) => spotifyBloc,
                  child: albumsScreen,
                ),
              );
            },
          ),
        );
        await tester.pumpWidget(app);
        var nextBtn = find.byKey(Key('NextScreenBtn'));
        expect(nextBtn, findsOneWidget);
        spotifyBloc.close();
      });
    });

    group('Spotify Test', () {
      AlbumsList albumsList = AlbumsList();
      blocTest('Getting Albums Success',
          build: () {
            when(mockSpotifyRepo.getAlbumsList()).thenAnswer(
              (_) async => albumsList,
            );
            return SpotifyBloc(spotifyRepo: mockSpotifyRepo);
          },
          act: (bloc) => bloc.add(SpotifyEvents.fetchAlbums),
          expect: [
            AlbumsLoading(),
            AlbumsLoaded(albumsList),
          ]);

      blocTest('Network Error Test',
          build: () {
            when(mockSpotifyRepo.getAlbumsList()).thenThrow(
              SocketException('Internet Error'),
            );
            return SpotifyBloc(spotifyRepo: mockSpotifyRepo);
          },
          act: (bloc) => bloc.add(SpotifyEvents.fetchAlbums),
          expect: [
            AlbumsLoading(),
            AlbumListError(error: NoInternetException('Internet Error')),
          ]);
    });
  });
}
