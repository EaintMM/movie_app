import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/network/api.dart';
import 'package:movie_app/pages/detail_page.dart';

import '../models/movie.dart';

class SearchList extends StatefulWidget {
  List<Movie> list;
  SearchList({Key? key, required this.list}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        Movie m = widget.list[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          movie: m,
                          htag: m.id.toString(),
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 180,
                  //child: Image.network(API.imageURL + m.posterPath),
                  child: Hero(
                    tag: m.id.toString(),
                    transitionOnUserGestures: true,
                    child: Image(
                        image: CachedNetworkImageProvider(
                            API.imageURL + m.posterPath)),
                  ),
                ),
                SizedBox(
                  //child: Text(m.id.toString()),
                  width: 12,
                ),
                Text(m.title)
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
