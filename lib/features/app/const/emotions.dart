class Emotion {
  final String name;
  final String asset;
  final List<String> descriptions;

  Emotion({
    required this.name,
    required this.asset,
    required this.descriptions,
  });
}

final List<Emotion> emotions = [
  Emotion(
    name: 'Радость',
    asset: 'assets/images/joy.png',
    descriptions: [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелость',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Экстравагантность',
    ],
  ),
  Emotion(
    name: 'Страх',
    asset: 'assets/images/fear.png',
    descriptions: [
      'Тревога',
      'Испуг',
      'Беспокойство',
      'Паника',
      'Опасение',
      'Нервозность',
    ],
  ),
  Emotion(
    name: 'Бешенство',
    asset: 'assets/images/rage.png',
    descriptions: [
      'Злость',
      'Гнев',
      'Раздражение',
      'Негодование',
      'Враждебность',
    ],
  ),
  Emotion(
    name: 'Грусть',
    asset: 'assets/images/sadness.png',
    descriptions: ['Печаль', 'Огорчение', 'Разочарование', 'Тоска', 'Уныние'],
  ),
  Emotion(
    name: 'Спокойствие',
    asset: 'assets/images/calmness.png',
    descriptions: [
      'Расслабленность',
      'Умиротворение',
      'Безмятежность',
      'Комфорт',
    ],
  ),
  Emotion(
    name: 'Сила',
    asset: 'assets/images/strength.png',
    descriptions: ['Уверенность', 'Мужество', 'Решимость', 'Настойчивость'],
  ),
];
