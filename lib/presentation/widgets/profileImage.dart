import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  ProfileImage({this.url});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url == null
          ? "https://spnafricanews.com/wp-content/uploads/2020/07/KDB-1024x576.jpg"
          : url,
      imageBuilder: (context, imageProvider) => Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
