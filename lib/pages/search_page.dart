import 'package:flutter/material.dart';
import 'package:movie_app/components/search_list.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/network/api.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var movieAPI = API();
  List<Movie>? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              movieAPI.getSearch(value).then((value) {
                setState(() {
                  result = value;
                  //print(result!.length);
                });
              });
            },
            decoration:  InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(color: Colors.black), 
              hintText: "Search"),
      ),
          )),
      body: result == null
          ? Text("Please Search First")
          : SearchList(list: result!),
    );
  }
}
