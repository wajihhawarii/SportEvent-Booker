import 'package:ci_projecct/core/shared/widgets/cach_network_image.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/features/bookings/domain/entities/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.h,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // ================= IMAGE =================
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CustomCachNetworkImage(imagePath: booking.image),
              ),
              SizedBox(width: 12.h),
              // ================= CONTENT =================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      booking.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16.sp,
                          color: AppColors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          formatDate(booking.bookedAt),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),
                    // Status
                    buildStatusBadge(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= BADGE =================
  Widget buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.green15,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        AppText.booked,
        style: TextStyle(
          color: AppColors.green,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= DATE FORMAT =================
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
