import 'package:evotest/features/diary/data/remote/mood_remote_data_source.dart';
import 'package:evotest/features/diary/data/remote/mood_remote_data_source_impl.dart';
import 'package:evotest/features/diary/data/repository/mood_repository_impl.dart';
import 'package:evotest/features/diary/domain/repository/mood_repository.dart';
import 'package:evotest/features/diary/domain/usecases/save_mood_entry_usecase.dart';
import 'package:evotest/features/diary/domain/usecases/get_mood_entries_usecase.dart';
import 'package:evotest/features/diary/presentation/bloc/mood/mood_bloc.dart';
import 'package:evotest/features/diary/presentation/bloc/stats/stats_bloc.dart';
import 'package:evotest/main_injection_container.dart';

Future<void> moodInjectionContainer() async {
  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerSingleton<MoodRemoteDataSource>(
    MoodRemoteDataSourceImpl(fireStore: sl.call()),
  );
  sl.registerSingleton<MoodRepository>(
    MoodRepositoryImpl(remoteDataSource: sl.call()),
  );

  // * USE CASES INJECTION

  sl.registerSingleton<SaveMoodEntryUsecase>(
    SaveMoodEntryUsecase(repository: sl.call()),
  );
  sl.registerSingleton<GetMoodEntriesUsecase>(
    GetMoodEntriesUsecase(repository: sl.call()),
  );

  // * BLOC INJECTION
  sl.registerSingleton<MoodBloc>(
    MoodBloc(saveMoodEntryUsecase: sl<SaveMoodEntryUsecase>()),
  );
  sl.registerSingleton<StatsBloc>(StatsBloc(sl<GetMoodEntriesUsecase>()));
}
