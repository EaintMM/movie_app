import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/components/search_list.dart';
import 'package:movie_app/controllers/search_controller.dart';


class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController c = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            c.searchMovie(value);
          },
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white), hintText: "Search"),
        )),
        body: Obx(() {
          return c.searchResult.isEmpty
              ? const Text("Please Search First")
              : SearchList(list: c.searchResult);
        })
    );
  }
}
