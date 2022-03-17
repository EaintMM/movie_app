import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/network/api.dart';


class BlurBackground extends StatelessWidget {
  String backdropPath;
  BlurBackground({Key? key, required this.backdropPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: backdropPath==""?  CachedNetworkImageProvider( "https://images.assetsdelivery.com/compings_v2/viktostock/viktostock2004/viktostock200401589.jpg"): CachedNetworkImageProvider(API.imageURL + backdropPath),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
