import 'package:dartz/dartz.dart';
import 'package:tryevo/core/error/failures.dart';
import 'package:tryevo/features/diary/domain/entities/mood_entity.dart';

abstract class MoodRepository {
  Future<Either<Failure, MoodEntity>> saveMoodEntry(MoodEntity mood);
  Future<Either<Failure, List<MoodEntity>>> getMoodEntries();
}
