import 'package:ci_projecct/core/utils/network/api_error_model.dart';
import 'package:dartz/dartz.dart';
import '../entities/event.dart';

abstract class EventRepository {
  Future<Either<ApiErrorModel, List<Event>>> getEvents();
}
