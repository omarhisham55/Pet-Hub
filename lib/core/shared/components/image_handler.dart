import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHandler extends StatelessWidget {
  final String image;
  final bool isBase64;
  const ImageHandler({super.key, required this.image, this.isBase64 = true});

  String convertBase64ToUrl(String base64Image) {
    return 'data:image/png;base64,' + base64Image;
  }

  @override
  Widget build(BuildContext context) {
    if (isBase64) {
      // If the image is base64, use Image.memory to display it
      Uint8List imageBytes =
          base64Decode(image); // Decode base64 string to bytes
      return Image.memory(
        imageBytes,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/no_image.png');
        },
      );
    } else if (image.endsWith('.svg')) {
      // If the image is SVG, use SvgPicture
      return SvgPicture.asset(
        image,
        fit: BoxFit.contain,
      );
    } else {
      // If the image is not base64 or SVG, use CachedNetworkImage
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        placeholder: (context, url) => Image.asset('assets/no_image.png'),
        errorWidget: (context, url, error) {
          return Image.asset('assets/no_image.png');
        },
      );
    }
  }
}
