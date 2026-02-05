import 'package:ci_projecct/core/di/dependency_injection.dart';
import 'package:ci_projecct/features/bookings/presentation/cubit/booking_cubit.dart';
import 'package:ci_projecct/features/bookings/presentation/pages/my_bookings_page.dart';
import 'package:ci_projecct/features/events/domain/entities/event.dart';
import 'package:ci_projecct/features/events/presentation/cubit/event_cubit.dart';
import 'package:ci_projecct/features/events/presentation/pages/event_details_page.dart';
import 'package:ci_projecct/features/events/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<EventCubit>(),
                child: HomePage(),
              ),
        );

      case Routes.eventDetailesPage:
        final args = settings.arguments as Map<String, dynamic>;
        final event = args['event'] as Event;
        final eventCubit = args['cubit'] as EventCubit;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: eventCubit),
                  BlocProvider(create: (_) => getIt<BookingCubit>()),
                ],
                child: EventDetailsPage(event: event),
              ),
        );
      case Routes.myBookingPage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<BookingCubit>(),
                child: MyBookingsPage(),
              ),
        );

      default:
        return null;
    }
  }
}
