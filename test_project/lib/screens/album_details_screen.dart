import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_project/apis/Services.dart';
import 'package:test_project/models/album_details.dart';
import 'package:test_project/models/albums_list.dart';
import 'package:test_project/widgets/loading.dart';

class AlbumDetailsScreen extends StatefulWidget {
  //
  AlbumDetailsScreen({this.album});
  final Album album;

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  //
  AlbumDetails _albumDetails;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getDetails();
  }

  _getDetails() async {
    _loading = true;
    _albumDetails =
        await SpotifyAlbumServices().getAlbumDetails(widget.album.id);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading...' : _albumDetails.name),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              _loading
                  ? Loading()
                  : Container(
                      child: CachedNetworkImage(
                        imageUrl: _albumDetails.images[0].url,
                      ),
                    ),
            ],
          ),
        ));
  }
}
