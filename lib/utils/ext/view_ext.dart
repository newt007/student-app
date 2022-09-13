import 'package:flutter/material.dart';

extension ViewExt on Image {
  Image setImageUrl(String url) => Image.network("https://image.tmdb.org/t/p/w500/" + url);
}