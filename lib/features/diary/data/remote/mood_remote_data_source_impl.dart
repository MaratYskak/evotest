import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evotest/core/error/failures.dart';
import 'package:evotest/features/diary/data/models/mood_model.dart';
import 'package:evotest/features/diary/data/remote/mood_remote_data_source.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final FirebaseFirestore fireStore;

  MoodRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<Either<Failure, MoodEntity>> saveMoodEntry(MoodModel mood) async {
    try {
      await fireStore.collection('moods').add(mood.toDocument());
      return Right(mood);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MoodEntity>>> getMoodEntries() async {
    try {
      final snapshot = await fireStore.collection('moods').get();
      final moods = snapshot.docs
          .map((doc) => MoodModel.fromSnapshot(doc))
          .toList();
      return Right(moods);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
