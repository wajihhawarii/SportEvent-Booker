import 'package:ci_projecct/core/shared/widgets/custom_circule.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/features/bookings/presentation/cubit/booking_cubit.dart';
import 'package:ci_projecct/features/bookings/presentation/cubit/booking_state.dart';
import 'package:ci_projecct/features/bookings/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  late BookingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<BookingCubit>();
    cubit.loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: const Text(
          AppText.mybookings,
          style: TextStyle(color: AppColors.white),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          // ================= LOADING =================
          if (state is BookingLoading) {
            return const Center(child: CustomCircule());
          }
          // ================= LOADED =================
          if (state is BookingLoaded) {
            if (state.bookings.isEmpty) {
              return buildEmptyState();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.bookings.length,
              itemBuilder: (_, index) {
                final booking = state.bookings[index];
                return BookingCard(booking: booking);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // ================= EMPTY STATE =================
  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80.h, color: AppColors.grey400),
          SizedBox(height: 16.h),
          Text(
            AppText.noBookingsYet,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
