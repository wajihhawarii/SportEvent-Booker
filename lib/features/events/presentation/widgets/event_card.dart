import 'package:ci_projecct/core/shared/widgets/cach_network_image.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventCard({required this.event, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '${AppText.eventImage}${event.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  //CachNetworkImage component
                  child: CustomCachNetworkImage(imagePath: event.image),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${event.date.toLocal()}".split(' ')[0],
                      style: TextStyle(color: AppColors.grey, fontSize: 13.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "\$${event.price}",
                      style: TextStyle(
                        color: AppColors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${AppText.available} ${event.availableSpots}",
                      style: TextStyle(
                        color:
                            event.availableSpots > 0
                                ? AppColors.black54
                                : AppColors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
