import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evotest/features/diary/domain/usecases/save_mood_entry_usecase.dart';
import '../../../domain/entities/mood_entity.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final SaveMoodEntryUsecase saveMoodEntryUsecase;

  MoodBloc({required this.saveMoodEntryUsecase}) : super(MoodInitial()) {
    on<AddMoodEvent>(_onAddMood);
  }

  Future<void> _onAddMood(AddMoodEvent event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    final mood = MoodEntity(
      feeling: event.feeling,
      stressLevel: event.stressLevel,
      selfEsteemLevel: event.selfEsteemLevel,
      note: event.note,
      date: event.date,
    );
    final result = await saveMoodEntryUsecase(mood);
    result.fold(
      (failure) => emit(MoodError(failure.message)),
      (mood) => emit(MoodAdded(mood)),
    );
  }
}
