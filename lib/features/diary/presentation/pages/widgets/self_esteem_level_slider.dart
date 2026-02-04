import 'package:flutter/material.dart';
import 'package:evotest/features/app/theme/colors.dart';
import 'package:evotest/features/app/theme/text_theme.dart';

class SelfEsteemLevelSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const SelfEsteemLevelSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<SelfEsteemLevelSlider> createState() => _SelfEsteemLevelSliderState();
}

class _SelfEsteemLevelSliderState extends State<SelfEsteemLevelSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // Определяем, выбрано ли значение (больше 0)
    bool isSelected = _currentValue > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: isSelected ? kOrangeColor : kDateTextColor,
              inactiveTrackColor: kDateTextColor,
              trackHeight: 6.0,
              thumbColor: isSelected ? kOrangeColor : kLightGray,
              overlayColor: kOrangeColor.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              tickMarkShape: const RoundSliderTickMarkShape(
                tickMarkRadius: 2.0,
              ),
              activeTickMarkColor: Colors.white.withOpacity(0.5),
              inactiveTickMarkColor: kTextGray,
            ),
            child: Slider(
              value: _currentValue,
              min: 0,
              max: 6,
              divisions: 6,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
          // Подписи под слайдером
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Неуверенность',
                  style: TextStyle(color: kTextGray, fontSize: 12),
                ),
                Text(
                  'Уверенность',
                  style: TextStyle(color: kTextGray, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
