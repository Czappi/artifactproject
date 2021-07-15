import 'dart:ui';

import 'package:flutter/material.dart';

class BluredImage extends StatelessWidget {
  final ImageProvider image;
  final double blur;
  final Color blurColor;
  const BluredImage({
    Key? key,
    required this.image,
    this.blur = 10.0,
    this.blurColor = const Color.fromARGB(25, 255, 255, 255),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(color: blurColor),
          ),
        ),
      ),
    );
  }
}
