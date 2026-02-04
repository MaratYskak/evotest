import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evotest/features/diary/domain/usecases/get_mood_entries_usecase.dart';
import 'package:evotest/features/diary/domain/entities/mood_entity.dart';

part 'stats_state.dart';
part 'stats_event.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetMoodEntriesUsecase getMoodEntriesUsecase;
  StatsBloc(this.getMoodEntriesUsecase) : super(StatsInitial()) {
    on<GetStatsEvent>(_onGetStats);
  }

  Future<void> _onGetStats(
    GetStatsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(StatsLoading());
    final result = await getMoodEntriesUsecase();
    result.fold((failure) => emit(StatsError(failure.message)), (moodEntries) {
      final statsData = _calculateStats(moodEntries);
      emit(StatsLoaded(statsData, moodEntries));
    });
  }

  Map<String, dynamic> _calculateStats(List<MoodEntity> moodEntries) {
    if (moodEntries.isEmpty) {
      return {
        'totalEntries': 0,
        'averageStressLevel': 0.0,
        'averageSelfEsteemLevel': 0.0,
        'mostCommonFeeling': 'No data',
      };
    }

    final totalEntries = moodEntries.length;
    final averageStressLevel =
        moodEntries.map((e) => e.stressLevel).reduce((a, b) => a + b) /
        totalEntries;
    final averageSelfEsteemLevel =
        moodEntries.map((e) => e.selfEsteemLevel).reduce((a, b) => a + b) /
        totalEntries;

    final feelingCounts = <String, int>{};
    for (final mood in moodEntries) {
      feelingCounts[mood.feeling] = (feelingCounts[mood.feeling] ?? 0) + 1;
    }
    final mostCommonFeeling = feelingCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return {
      'totalEntries': totalEntries,
      'averageStressLevel': averageStressLevel,
      'averageSelfEsteemLevel': averageSelfEsteemLevel,
      'mostCommonFeeling': mostCommonFeeling,
    };
  }
}
