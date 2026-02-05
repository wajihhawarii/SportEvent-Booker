import 'package:ci_projecct/core/utils/network/network_info.dart';
import 'package:ci_projecct/features/bookings/data/datasources/booking_local_db.dart';
import 'package:ci_projecct/features/bookings/data/repositories/booking_repository_impl.dart';
import 'package:ci_projecct/features/bookings/domain/repositories/booking_repository.dart';
import 'package:ci_projecct/features/bookings/domain/usecases/add_booking_usecase.dart';
import 'package:ci_projecct/features/bookings/domain/usecases/get_bookings_usecase.dart';
import 'package:ci_projecct/features/bookings/presentation/cubit/booking_cubit.dart';
import 'package:ci_projecct/features/events/data/data_sources/event_local_data_source.dart';
import 'package:ci_projecct/features/events/data/repositories/event_repository_impl.dart';
import 'package:ci_projecct/features/events/domain/repositories/event_repository.dart';
import 'package:ci_projecct/features/events/domain/usecases/get_events_usecase.dart';
import 'package:ci_projecct/features/events/presentation/cubit/event_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // -----------------------------
  // Data Sources
  // -----------------------------
  getIt.registerLazySingleton(() => Connectivity());

  // NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  // DataSource
  getIt.registerLazySingleton<EventLocalDataSource>(
    () => EventLocalDataSource(),
  );

  //Repository
  getIt.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(
      localDataSource: getIt<EventLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  // -----------------------------
  // UseCases
  // -----------------------------
  getIt.registerLazySingleton<GetEventsUseCase>(
    () => GetEventsUseCase(getIt<EventRepository>()),
  );

  // -----------------------------
  // Cubits
  // -----------------------------
  getIt.registerFactory<EventCubit>(
    () => EventCubit(getEventsUseCase: getIt<GetEventsUseCase>()),
  );

  //******************************************** */
  // Database

  // Booking
  getIt.registerLazySingleton<BookingLocalDataSource>(
    () => BookingLocalDataSource(),
  );

  // Repository
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerLazySingleton(
    () => AddBookingUseCase(getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetBookingsUseCase(getIt<BookingRepository>()),
  );

  // Cubit
  getIt.registerFactory(
    () => BookingCubit(
      addBooking: getIt<AddBookingUseCase>(),
      getBookings: getIt<GetBookingsUseCase>(),
    ),
  );
}
