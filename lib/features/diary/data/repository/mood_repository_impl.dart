import 'package:dartz/dartz.dart';
import 'package:evotest/core/error/failures.dart';
import 'package:evotest/features/diary/data/models/mood_model.dart';
import 'package:evotest/features/diary/data/remote/mood_remote_data_source.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';
import 'package:evotest/features/diary/domain/repository/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource remoteDataSource;

  MoodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MoodEntity>> saveMoodEntry(MoodEntity mood) {
    return remoteDataSource.saveMoodEntry(MoodModel.fromEntity(mood));
  }

  @override
  Future<Either<Failure, List<MoodEntity>>> getMoodEntries() {
    return remoteDataSource.getMoodEntries();
  }
}
