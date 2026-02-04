part of 'stats_bloc.dart';

abstract class StatsState extends Equatable {}

class StatsInitial extends StatsState {
  @override
  List<Object?> get props => [];
}

class StatsLoading extends StatsState {
  @override
  List<Object?> get props => [];
}

class StatsLoaded extends StatsState {
  final Map<String, dynamic> statsData;
  final List<MoodEntity> moods;

  StatsLoaded(this.statsData, this.moods);

  @override
  List<Object?> get props => [statsData, moods];
}

class StatsError extends StatsState {
  final String message;

  StatsError(this.message);

  @override
  List<Object?> get props => [message];
}
