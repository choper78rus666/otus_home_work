// Вспомогательные функции

// Функция конвертации минут в строковое представление
String timeToString(int time) {
  String result = '';

  if (time > 0) {
    int hours = time ~/ 60;
    int minutes = time % 60;

    if (hours > 0) result = convertNumString(hours, ['час', 'часа', 'часов']);

    result += minutes > 0 && hours > 0 ? ' ' : '';

    if (minutes > 0) {
      result += convertNumString(minutes, ['минута', 'минуты', 'минут']);
    }

    return result;
  }

  return result;
}

// Функция возвращает склонения в зависимости от числа
String convertNumString(int value, List strList) {
  String result = '';
  int checkValue = value % 100;

  if (checkValue > 19) {
    checkValue = checkValue % 10;
  }

  switch (checkValue) {
    case 1:
      result = strList[0];
      break;
    case 2:
    case 3:
    case 4:
      result = strList[1];
      break;

    default:
      result = strList[2];
  }

  return '${value.toString()} ${result}';
}
