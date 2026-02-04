import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evotest/features/app/home/home_page.dart';
import 'package:evotest/features/diary/presentation/bloc/mood/mood_bloc.dart';
import 'package:evotest/features/diary/presentation/bloc/stats/stats_bloc.dart';
import 'package:evotest/firebase_options.dart';
import 'main_injection_container.dart' as di;
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting('ru', null);

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''), // Русский язык
      ],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<StatsBloc>()),
          BlocProvider(create: (context) => di.sl<MoodBloc>()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
