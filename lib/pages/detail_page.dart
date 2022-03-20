import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/components/blur_background.dart';
import 'package:movie_app/controllers/details_controller.dart';
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
  final DetailsController c = Get.put(DetailsController());
  @override
  void initState() {
    c.loadCast(widget.movie.id);
    super.initState();
  }

  _castInformation() => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: c.castList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Cast cast = c.castList[index];
          //print(c.profilePath);
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                cast.profilePath == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage('images/avatar.png'),
                      )
                    : CircleAvatar(
                        //radius: 40,
                        child: CachedNetworkImage(
                        imageUrl: API.imageURL + cast.profilePath!,
                        placeholder: (context, url) =>
                            Image.asset("images/avatar.png"),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          //radius: 40,
                        ),
                      )
                        //backgroundImage: CachedNetworkImageProvider(API.imageURL + c.profilePath!,
                        ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cast.originalName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        cast.character,
                        style: TextStyle(color: Colors.white24),
                        //overflow: TextOverflow.ellipsis,
                        //maxLines: 3,
                      ),
                    ],
                  ),
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
                tag: widget.htag,
                child: FadeInImage(
                  image: CachedNetworkImageProvider(
                      API.imageURL + widget.movie.posterPath),
                  placeholder: AssetImage("images/movie_bg.jpg"),
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
            backdropPath: widget.movie.backdropPath == null
                ? ""
                : widget.movie.backdropPath!,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _movieInformation(),
                SizedBox(
                  height: 12,
                ),
                c.castList == null
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
