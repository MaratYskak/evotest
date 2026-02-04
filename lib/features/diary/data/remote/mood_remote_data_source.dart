import 'package:dartz/dartz.dart';
import 'package:evotest/core/error/failures.dart';
import 'package:evotest/features/diary/data/models/mood_model.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';

abstract class MoodRemoteDataSource {
  Future<Either<Failure, MoodEntity>> saveMoodEntry(MoodModel mood);
  Future<Either<Failure, List<MoodEntity>>> getMoodEntries();
}
