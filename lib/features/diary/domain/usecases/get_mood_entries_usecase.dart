import 'package:dartz/dartz.dart';
import 'package:tryevo/core/error/failures.dart';
import 'package:tryevo/features/diary/domain/entities/mood_entity.dart';
import 'package:tryevo/features/diary/domain/repository/mood_repository.dart';

class GetMoodEntriesUsecase {
  final MoodRepository repository;

  GetMoodEntriesUsecase({required this.repository});

  Future<Either<Failure, List<MoodEntity>>> call() {
    return repository.getMoodEntries();
  }
}
