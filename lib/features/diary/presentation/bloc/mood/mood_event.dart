part of 'mood_bloc.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object> get props => [];
}

class GetMoodsEvent extends MoodEvent {
  const GetMoodsEvent();
}

class AddMoodEvent extends MoodEvent {
  final String feeling;
  final int stressLevel;
  final int selfEsteemLevel;
  final String note;
  final DateTime date;

  const AddMoodEvent({
    required this.feeling,
    required this.stressLevel,
    required this.selfEsteemLevel,
    required this.note,
    required this.date,
  });

  @override
  List<Object> get props => [feeling, stressLevel, selfEsteemLevel, note, date];
}
