import 'package:dartz/dartz.dart';
import 'package:evotest/core/error/failures.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';

abstract class MoodRepository {
  Future<Either<Failure, MoodEntity>> saveMoodEntry(MoodEntity mood);
  Future<Either<Failure, List<MoodEntity>>> getMoodEntries();
}
