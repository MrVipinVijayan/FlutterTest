import 'package:flutter/material.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:test_project/screens/album_details_screen.dart';
import 'package:test_project/screens/home_page.dart';

class ScreenUtils {
  //
  static openHomeScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  static openAlbumDetailsScreen({BuildContext context, Album album}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetailsScreen(
          album: album,
        ),
      ),
    );
  }
}
