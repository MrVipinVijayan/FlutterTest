import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/bloc/albums_bloc.dart';
import 'package:test_project/bloc/theme_bloc.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:test_project/utils/screen_utils.dart';
import 'package:test_project/utils/theme.dart';
import 'package:test_project/widgets/list_row.dart';
import 'package:test_project/widgets/loading.dart';
import 'package:test_project/widgets/retry.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  //
  bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = false;
    _loadAlbums();
  }

  _loadAlbums() async {
    context.bloc<SpotifyBloc>().add(SpotifyEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Albums'),
        actions: [
          Switch(
            value: _isDarkTheme,
            onChanged: (val) {
              _isDarkTheme = !_isDarkTheme;
              _toggleTheme(context);
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).backgroundColor,
        child: _body(),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    var theme = _isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: theme));
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BlocBuilder<SpotifyBloc, SpotifyState>(
            builder: (BuildContext context, SpotifyState state) {
          if (state is AlbumsLoading) {
            return Loading();
          }
          if (state is AlbumListError) {
            return Retry(
              message: state.error.message,
              onTap: _loadAlbums,
            );
          }
          if (state is AlbumsLoaded) {
            AlbumsList albumsList = state.albumsList;
            return list(albumsList);
          }
          return Loading();
        }),
        RaisedButton(
          key: Key('NextScreenBtn'),
          onPressed: () {
            ScreenUtils.openRegistrationScreen(context);
          },
          child: Text(
            'Open Next Screen',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget list(AlbumsList albumsList) {
    return Expanded(
      child: ListView.builder(
        itemCount: albumsList.albums.length,
        itemBuilder: (_, index) {
          Album album = albumsList.albums[index];
          return ListRow(
            album: album,
            onTap: () async {
              ScreenUtils.openAlbumDetailsScreen(
                context: context,
                album: album,
              );
            },
          );
        },
      ),
    );
  }
}
