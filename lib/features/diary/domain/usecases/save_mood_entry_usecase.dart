import 'package:dartz/dartz.dart';
import 'package:evotest/core/error/failures.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';
import 'package:evotest/features/diary/domain/repository/mood_repository.dart';

class SaveMoodEntryUsecase {
  final MoodRepository repository;

  SaveMoodEntryUsecase({required this.repository});

  Future<Either<Failure, MoodEntity>> call(MoodEntity mood) async {
    return await repository.saveMoodEntry(mood);
  }
}
