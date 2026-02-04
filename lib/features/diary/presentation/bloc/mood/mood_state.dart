part of 'mood_bloc.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {
  const MoodInitial();
}

class MoodLoading extends MoodState {
  const MoodLoading();
}

class MoodLoaded extends MoodState {
  final List<MoodEntity> moods;

  const MoodLoaded(this.moods);

  @override
  List<Object> get props => [moods];
}

class MoodAdded extends MoodState {
  final MoodEntity mood;

  const MoodAdded(this.mood);

  @override
  List<Object> get props => [mood];
}

class MoodError extends MoodState {
  final String message;

  const MoodError(this.message);

  @override
  List<Object> get props => [message];
}
