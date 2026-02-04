import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';

class MoodModel extends MoodEntity {
  MoodModel({
    required String feeling,
    required int stressLevel,
    required int selfEsteemLevel,
    required String note,
    required DateTime date,
  }) : super(
         feeling: feeling,
         stressLevel: stressLevel,
         selfEsteemLevel: selfEsteemLevel,
         note: note,
         date: date,
       );

  factory MoodModel.fromSnapshot(DocumentSnapshot snapshot) {
    return MoodModel(
      feeling: snapshot['feeling'],
      stressLevel: snapshot['stressLevel'],
      selfEsteemLevel: snapshot['selfEsteemLevel'],
      note: snapshot['note'],
      date: DateTime.parse(snapshot['date']),
    );
  }

  Map<String, dynamic> toDocument() => {
    'feeling': feeling,
    'stressLevel': stressLevel,
    'selfEsteemLevel': selfEsteemLevel,
    'note': note,
    'date': date.toIso8601String(),
  };

  factory MoodModel.fromEntity(MoodEntity entity) {
    return MoodModel(
      feeling: entity.feeling,
      stressLevel: entity.stressLevel,
      selfEsteemLevel: entity.selfEsteemLevel,
      note: entity.note,
      date: entity.date,
    );
  }

  MoodEntity toEntity() {
    return MoodEntity(
      feeling: feeling,
      stressLevel: stressLevel,
      selfEsteemLevel: selfEsteemLevel,
      note: note,
      date: date,
    );
  }
}
