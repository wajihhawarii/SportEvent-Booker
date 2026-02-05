import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_images.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/features/events/presentation/cubit/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  final String text;
  const CustomErrorWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(AppImages.noInternet, fit: BoxFit.cover),
          ),
          Text(text),
          SizedBox(height: 12.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              context.read<EventCubit>().loadEvents();
            },
            child: SizedBox(
              width: 100.w,
              child: Center(
                child: const Text(
                  AppText.retry,
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
