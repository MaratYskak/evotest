import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:evotest/features/app/const/icons.dart';
import 'package:evotest/features/app/home/widgets/page_toggle.dart';
import 'package:evotest/features/app/theme/text_theme.dart';
import 'package:evotest/features/diary/presentation/pages/mood_screen.dart';
import 'package:evotest/features/diary/presentation/pages/stats_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  DateTime _selectedDateTime = DateTime.now();

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ru', ''),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('ru', ''),
          child: child,
        );
      },
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedPage == 0
          ? AppBar(
              centerTitle: true,
              title: GestureDetector(
                onTap: _pickDateTime,
                child: Text(
                  DateFormat('d MMMM H:mm', 'ru').format(_selectedDateTime),
                  style: kDateTextStyle,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: _pickDateTime,
                    child: SvgPicture.asset(calendar, width: 24, height: 24),
                  ),
                ),
              ],
            )
          : AppBar(
              centerTitle: true,
              title: const Text('Статистика', style: kDateTextStyle),
            ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: PageToggle(
              currentIndex: _selectedPage,
              onIndexChanged: (index) {
                setState(() {
                  _selectedPage = index;
                });
              },
            ),
          ),
          Expanded(
            child: _selectedPage == 0
                ? MoodScreen(date: _selectedDateTime)
                : StatsScreen(),
          ),
        ],
      ),
    );
  }
}
