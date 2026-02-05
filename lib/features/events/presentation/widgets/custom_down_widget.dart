import 'dart:async';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime startTime;
  const CountdownWidget({super.key, required this.startTime});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer timer;
  late Duration remaining;

  @override
  void initState() {
    super.initState();
    calculateRemaining();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      calculateRemaining();
    });
  }

  void calculateRemaining() {
    final now = DateTime.now();
    setState(() {
      remaining =
          widget.startTime.isAfter(now)
              ? widget.startTime.difference(now)
              : Duration.zero;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (remaining == Duration.zero) {
      return const Text(
        AppText.eventStarted,
        style: TextStyle(color: AppColors.red),
      );
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(remaining.inHours);
    final minutes = twoDigits(remaining.inMinutes.remainder(60));
    final seconds = twoDigits(remaining.inSeconds.remainder(60));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer, size: 16.sp, color: AppColors.orange),
        SizedBox(width: 4.w),
        Text(
          "$hours:$minutes:$seconds",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}
