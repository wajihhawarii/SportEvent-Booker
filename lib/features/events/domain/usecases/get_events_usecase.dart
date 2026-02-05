import 'package:ci_projecct/core/utils/network/api_error_model.dart';
import 'package:dartz/dartz.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<Either<ApiErrorModel, List<Event>>> call() {
    return repository.getEvents();
  }
}
