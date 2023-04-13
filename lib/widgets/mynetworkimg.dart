import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyNetworkImage extends StatelessWidget {
  String imageUrl;
  double? imgHeight, imgWidth;
  dynamic fit;

  MyNetworkImage(
      {Key? key,
      required this.imageUrl,
      required this.fit,
      this.imgHeight,
      this.imgWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imgHeight,
      width: imgWidth,
      child: Image.network(imageUrl, fit: fit),
    );
  }
}
