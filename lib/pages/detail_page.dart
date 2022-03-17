import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/blur_background.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/network/api.dart';

class DetailPage extends StatefulWidget {
  Movie movie;
  String htag = "";
  DetailPage({Key? key, required this.movie, required this.htag})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;
  @override
  void initState() {
    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });
    super.initState();
  }

  _castInformation() => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: casts!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Cast c = casts![index];
          //print(c.profilePath);
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                c.profilePath == null
                    ? Container()
                    : CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            API.imageURL + c.profilePath!),
                      ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.originalName,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      c.character,
                      style: TextStyle(color: Colors.white24),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 3,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
  _movieInformation() => Column(
        children: [
          SizedBox(

              child: Hero(
                  tag: widget.htag ,
                  child: Image(
                image: CachedNetworkImageProvider(
                    API.imageURL + widget.movie.posterPath),
              )),
              
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            //child: Text('Tag is ' + widget.htag),
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Stack(
        children: [
          BlurBackground(
            backdropPath: widget.movie.backdropPath == null? "" : widget.movie.backdropPath!,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _movieInformation(),
                SizedBox(
                  height: 12,
                ),
                casts == null
                    ? const CircularProgressIndicator()
                    : _castInformation()
              ],
            ),
          )
        ],
      ),
    );
  }
}
