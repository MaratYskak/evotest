import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evotest/features/app/const/emotions.dart';
import 'package:evotest/features/app/theme/colors.dart';
import 'package:evotest/features/app/theme/text_theme.dart';
import 'package:evotest/features/diary/presentation/bloc/mood/mood_bloc.dart';
import 'package:evotest/features/diary/presentation/pages/widgets/mood_selector.dart';
import 'package:evotest/features/diary/presentation/pages/widgets/self_esteem_level_slider.dart';
import 'package:evotest/features/diary/presentation/pages/widgets/stress_level_slider.dart';

class MoodScreen extends StatefulWidget {
  final DateTime date;

  const MoodScreen({super.key, required this.date});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  Emotion? selectedEmotion;
  String? selectedDescription;
  int _stressLevel = 0;
  int _selfEsteemLevel = 0;
  final _noteController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.date;
    _noteController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _noteController.dispose(); // Не забываем освобождать ресурсы
    super.dispose();
  }

  bool get _isFormValid {
    return selectedEmotion != null &&
        selectedDescription != null &&
        _noteController.text.trim().isNotEmpty;
  }

  void _saveMood() {
    var feelings = selectedEmotion?.name ?? 'Neutral';
    feelings =
        feelings +
        (selectedDescription != null ? ' - $selectedDescription' : '');

    context.read<MoodBloc>().add(
      AddMoodEvent(
        feeling: feelings,
        stressLevel: _stressLevel,
        selfEsteemLevel: _selfEsteemLevel,
        note: _noteController.text,
        date: _selectedDateTime,
      ),
    );
    _noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoodBloc, MoodState>(
      listener: (context, state) {
        if (state is MoodAdded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Сохранено!')));
        } else if (state is MoodError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Что чувствуешь?', style: kHeadlineTextStyle),
            const SizedBox(height: 24),
            MoodSelector(
              selectedEmotion: selectedEmotion,
              selectedDescription: selectedDescription,
              onEmotionSelected: (emotion) => setState(() {
                selectedEmotion = emotion;
                selectedDescription = null;
              }),
              onDescriptionSelected: (desc) =>
                  setState(() => selectedDescription = desc),
            ),
            const SizedBox(height: 24),
            const Text('Уровень стресса', style: kHeadlineTextStyle),
            const SizedBox(height: 16),
            StressLevelSlider(
              initialValue: _stressLevel.toDouble(),
              onChanged: (value) =>
                  setState(() => _stressLevel = value.toInt()),
            ),
            const SizedBox(height: 16),
            const Text('Самооценка', style: kHeadlineTextStyle),
            const SizedBox(height: 16),
            SelfEsteemLevelSlider(
              initialValue: _selfEsteemLevel.toDouble(),
              onChanged: (value) =>
                  setState(() => _selfEsteemLevel = value.toInt()),
            ),
            const SizedBox(height: 32),
            const Text('Заметки', style: kHeadlineTextStyle),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Введите заметку',
                  hintStyle: TextStyle(color: kTextGray),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFormValid ? _saveMood : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isFormValid ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
