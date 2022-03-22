import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttersocial/model/color_theme.dart';
import 'package:fluttersocial/util/images.dart';

class ProfileImage extends InkWell {

  ProfileImage({
    required String? urlString,
    required VoidCallback onPressed,
    double imageSize: 20
  }): super(
      onTap: onPressed,
      child: (urlString != null && urlString != "")
          ? CircleAvatar(
          backgroundColor: ColorTheme().base(),
          radius: imageSize,
          backgroundImage:  CachedNetworkImageProvider(urlString))
          : CircleAvatar(
          backgroundColor: ColorTheme().base(),
          radius: imageSize,
          backgroundImage: AssetImage(logoImage)
      )
  );

}