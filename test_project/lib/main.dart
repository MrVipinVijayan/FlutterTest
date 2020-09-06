import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/apis/services.dart';
import 'package:test_project/bloc/albums_bloc.dart';
import 'package:test_project/bloc/theme_bloc.dart';
import 'package:test_project/screens/albums_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return MaterialApp(
            theme: themeState.themeData,
            home: BlocProvider(
              create: (context) => SpotifyBloc(
                spotifyRepo: SpotifyAlbumServices(),
              ),
              child: AlbumsScreen(),
            ),
          );
        },
      ),
    );
  }
}
