import 'package:ci_projecct/core/utils/network/api_error_handler.dart';
import 'package:ci_projecct/core/utils/network/api_error_model.dart';
import 'package:ci_projecct/core/utils/network/network_info.dart';
import 'package:ci_projecct/features/events/data/models/event_model.dart';
import 'package:ci_projecct/features/events/domain/entities/event.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/event_repository.dart';
import '../data_sources/event_local_data_source.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<ApiErrorModel, List<Event>>> getEvents() async {
    if (!await networkInfo.isConnected) {
      return Left(ApiErrorModel(message: "No internet connection", code: 0));
    }
    try {
      final data = await localDataSource.loadEvents();
      final events = data.map((e) => EventModel.fromJson(e)).toList();
      return Right(events);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
