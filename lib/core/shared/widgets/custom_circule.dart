import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircule extends StatelessWidget {
  const CustomCircule({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      color: AppColors.greenAccent,
    );
  }
}
