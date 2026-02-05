import 'package:cached_network_image/cached_network_image.dart';
import 'package:ci_projecct/core/shared/widgets/custom_circule.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCachNetworkImage extends StatelessWidget {
  final String imagePath;
  const CustomCachNetworkImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: const CustomCircule(),
          ),
      errorWidget:
          (context, url, error) => Container(
            width: 80,
            height: 80,
            color: AppColors.grey300,
            alignment: Alignment.center,
            child: const Icon(
              Icons.image_not_supported,
              color: AppColors.grey,
              size: 40,
            ),
          ),
    );
  }
}
