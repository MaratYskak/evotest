import 'package:flutter/material.dart';
import 'package:evotest/features/app/const/emotions.dart';
import 'package:evotest/features/app/theme/colors.dart';

class MoodSelector extends StatelessWidget {
  final Emotion? selectedEmotion;
  final String? selectedDescription;
  final ValueChanged<Emotion> onEmotionSelected;
  final ValueChanged<String> onDescriptionSelected;

  const MoodSelector({
    super.key,
    required this.selectedEmotion,
    required this.selectedDescription,
    required this.onEmotionSelected,
    required this.onDescriptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Горизонтальный скролл эмоций
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: emotions.map((emotion) {
              bool isSelected = selectedEmotion == emotion;
              return GestureDetector(
                onTap: () => onEmotionSelected(emotion),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 90,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(
                      color: isSelected ? kOrangeColor : Colors.transparent,
                      width: 2,
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Image.asset(
                        emotion.asset,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        emotion.name,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // 2. Список описаний (появляется только если выбрана эмоция)
        if (selectedEmotion != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8, // Отступ между кнопками по горизонтали
              runSpacing: 8, // Отступ между строками
              children: selectedEmotion!.descriptions.map((desc) {
                bool isDescSelected = selectedDescription == desc;
                return GestureDetector(
                  onTap: () => onDescriptionSelected(desc),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // Если выбрано — оранжевый фон, если нет — белый
                      color: isDescSelected ? kOrangeColor : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      desc,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
