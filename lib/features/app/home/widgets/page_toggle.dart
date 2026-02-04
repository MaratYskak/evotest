import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:evotest/features/app/theme/colors.dart';

class PageToggle extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const PageToggle({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: kInactiveBgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          // Анимированный оранжевый фон
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: currentIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                // margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kOrangeColor,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          // Кнопки
          Row(
            children: [
              _buildButton(0, 'assets/icons/diary.svg', 'Дневник настроения'),
              _buildButton(1, 'assets/icons/stats.svg', 'Статистика'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(int index, String svg, String label) {
    bool isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onIndexChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svg,
                height: 12,
                width: 12,
                color: isSelected ? Colors.white : kInactiveTextColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: isSelected ? Colors.white : kInactiveTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
