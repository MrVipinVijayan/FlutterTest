import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/bloc/theme_bloc.dart';
import 'package:test_project/models/albums_list.dart';

class ListRow extends StatelessWidget {
  //
  final Album album;
  final Function onTap;
  ListRow({this.album, this.onTap});

  final dim = 50.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            CachedNetworkImage(
              width: dim,
              height: dim,
              imageUrl: album.images[0].url,
              errorWidget: (context, url, error) => Container(
                width: dim,
                height: dim,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 20),
            Flexible(
                child: Text(
              album.name,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
