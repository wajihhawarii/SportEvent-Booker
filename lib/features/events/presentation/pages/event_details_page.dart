import 'package:ci_projecct/core/shared/widgets/custom_circule.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/features/bookings/data/models/booking_model.dart';
import 'package:ci_projecct/features/bookings/presentation/cubit/booking_cubit.dart';
import 'package:ci_projecct/features/events/presentation/cubit/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/event.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;
  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Event localEvent;

  @override
  void initState() {
    super.initState();
    localEvent = widget.event;
  }

  void bookTicket() {
    if (localEvent.availableSpots <= 0) return;
    context.read<EventCubit>().updateEventSpots(localEvent.id);
    setState(() {
      localEvent = localEvent.copyWith(
        availableSpots: localEvent.availableSpots - 1,
      );
    });
    context.read<BookingCubit>().addBooking(BookingModel.fromEvent(localEvent));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppText.bookingSuccessful),
        backgroundColor: AppColors.greenAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        title: Text(localEvent.title, style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '${AppText.eventImage}${localEvent.id}',
                child: CachedNetworkImage(
                  imageUrl: localEvent.image,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => const Center(child: CustomCircule()),
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          size: 60.h,
                          color: AppColors.grey,
                        ),
                      ),
                ),
              ),
              SizedBox(height: 16.sp),
              Text(
                localEvent.title,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text('${AppText.category} ${localEvent.category}'),
              SizedBox(height: 8.h),
              Text('${AppText.date} ${localEvent.date}'),
              SizedBox(height: 8.h),
              Text('${AppText.location} ${localEvent.id}'),
              SizedBox(height: 8.h),
              Text('${AppText.price} \$${localEvent.price.toStringAsFixed(2)}'),
              SizedBox(height: 8.h),
              Text(
                '${AppText.availableSpots} ${localEvent.availableSpots}',
                style: TextStyle(
                  color:
                      localEvent.availableSpots > 0
                          ? AppColors.black54
                          : AppColors.red,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                  ),
                  onPressed: localEvent.availableSpots > 0 ? bookTicket : null,
                  child: Text(
                    localEvent.availableSpots > 0
                        ? AppText.bookTicket
                        : AppText.soldOut,
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
