import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_app/core/utils/image_manager.dart';

class ImageHandler extends StatelessWidget {
  final String? image;
  final Uint8List? imageBytes;
  final String? errorImage;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  const ImageHandler({
    super.key,
    this.image,
    this.imageBytes,
    this.errorImage = noImage,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: () {
        if (imageBytes != null) {
          return Image.memory(
            imageBytes!,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                errorImage!,
                fit: fit,
                width: width,
                height: height,
              );
            },
          );
        } else if (image != null) {
          if (image!.endsWith('.svg')) {
            // If the image is SVG, use SvgPicture
            return SvgPicture.asset(image!,
                fit: fit, width: width, height: height);
          } else {
            // If the image is not base64 or SVG, use CachedNetworkImage
            return CachedNetworkImage(
              imageUrl: image!,
              fit: fit,
              width: width,
              height: height,
              placeholder: (context, url) => Image.asset(errorImage!,
                  fit: fit, width: width, height: height),
              errorWidget: (context, url, error) {
                return Image.asset(
                  errorImage!,
                  fit: BoxFit.contain,
                  width: width,
                  height: height,
                );
              },
            );
          }
        } else {
          return Image.asset(errorImage!,
              fit: fit, width: width, height: height);
        }
      }(),
    );
  }
}
