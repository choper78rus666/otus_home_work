// Матматические операции
class CalcFunc {
  // Считаем умножение
  String calcMultiply(parsing) {
    int lastIndex = 0;

    do {
      lastIndex = parsing.lastIndexOf('*');

      if (lastIndex != -1) {
        int negative = 1;

        // Проверка второго множителя на отрицательное число
        if (parsing[lastIndex + 1] == '-') {
          parsing = parsing.replaceRange(lastIndex + 1, lastIndex + 2, '');
          negative = -1;
        }

        Map<String, dynamic> leftRightVal =
            this.leftRightVal(parsing, lastIndex);
        double newValue =
            leftRightVal['leftValue'] * leftRightVal['rightValue'] * negative;

        //Проверка на оператор вычитания перед первым числом
        if (leftRightVal['leftIndex'] >= 1 &&
            parsing[leftRightVal['leftIndex'] - 1] == '-' &&
            newValue < 0) {
          newValue *= -1;
          parsing = parsing.replaceRange(
              leftRightVal['leftIndex'] - 1, leftRightVal['leftIndex'], '+');
        }
        //Проверка на оператор сложения перед первым числом
        else if (leftRightVal['leftIndex'] >= 1 &&
            parsing[leftRightVal['leftIndex'] - 1] == '+' &&
            newValue < 0) {
          leftRightVal['leftIndex'] -= 1;
        }

        parsing = parsing.replaceRange(leftRightVal['leftIndex'],
            leftRightVal['rightIndex'], newValue.toString());
      }
    } while (lastIndex != -1);

    return parsing;
  }

  // Считаем деление
  String calcDivide(parsing) {
    int lastIndex = 0;

    do {
      lastIndex = parsing.lastIndexOf('/');

      if (lastIndex != -1) {
        int negative = 1;

        // Проверка второго делителя на отрицательное число
        if (parsing[lastIndex + 1] == '-') {
          parsing = parsing.replaceRange(lastIndex + 1, lastIndex + 2, '');
          negative = -1;
        }

        Map<String, dynamic> leftRightVal =
            this.leftRightVal(parsing, lastIndex);

        // Проверка деления на ноль
        if (leftRightVal['rightValue'] == 0.0) return 'На ноль делить нельзя';

        double newValue =
            leftRightVal['leftValue'] / leftRightVal['rightValue'] * negative;

        //Проверка на оператор вычитания перед первым числом
        if (leftRightVal['leftIndex'] >= 1 &&
            parsing[leftRightVal['leftIndex'] - 1] == '-' &&
            newValue < 0) {
          newValue *= -1;
          parsing = parsing.replaceRange(
              leftRightVal['leftIndex'] - 1, leftRightVal['leftIndex'], '+');
        }

        //Проверка на оператор сложения перед первым числом
        else if (leftRightVal['leftIndex'] >= 1 &&
            parsing[leftRightVal['leftIndex'] - 1] == '+' &&
            newValue < 0) {
          leftRightVal['leftIndex'] -= 1;
        }

        parsing = parsing.replaceRange(leftRightVal['leftIndex'],
            leftRightVal['rightIndex'], newValue.toString());
      }
    } while (lastIndex != -1);

    return parsing;
  }

  // Считаем сложение
  String calcSum(parsing) {
    int lastIndex = 0;

    do {
      lastIndex = parsing.lastIndexOf('+');

      if (lastIndex != -1) {
        Map<String, dynamic> leftRightVal =
            this.leftRightVal(parsing, lastIndex);

        //Проверка на отрицательное первое число
        if (leftRightVal['leftIndex'] == 1 && parsing[0] == '-') {
          leftRightVal['leftValue'] *= -1;
          leftRightVal['leftIndex'] = 0;
        }

        double newValue =
            leftRightVal['leftValue'] + leftRightVal['rightValue'];
        parsing = parsing.replaceRange(leftRightVal['leftIndex'],
            leftRightVal['rightIndex'], newValue.toString());
      }
    } while (lastIndex != -1);

    return parsing;
  }

  // Считаем вычитание
  String calcDiff(parsing) {
    int lastIndex = 0;

    do {
      lastIndex = parsing.lastIndexOf('-');

      if (lastIndex > 0) {
        Map<String, dynamic> leftRightVal =
            this.leftRightVal(parsing, lastIndex);

        //Проверка на отрицательное первое число
        if (leftRightVal['leftIndex'] >= 1 &&
            parsing[leftRightVal['leftIndex'] - 1] == '-') {
          leftRightVal['leftValue'] *= -1;
          leftRightVal['leftIndex'] -= 1;
        }

        double newValue =
            leftRightVal['leftValue'] - leftRightVal['rightValue'];
        parsing = parsing.replaceRange(leftRightVal['leftIndex'],
            leftRightVal['rightIndex'], newValue.toString());
      }
    } while (lastIndex > 0);

    return parsing;
  }

  // Собираем значения с лева и справа от оператора вычисления
  Map<String, dynamic> leftRightVal(String parsing, int lastIndex) {
    int leftIndex = lastIndex - 1;
    int rightIndex = lastIndex + 1;
    String leftValue = '';
    String rightValue = '';
    var operators = ['(', ')', '+', '-', '*', '/'];

    while (leftIndex >= 0 && !operators.contains(parsing[leftIndex])) {
      leftValue = parsing[leftIndex] + leftValue;
      leftIndex--;
    }

    while (rightIndex < parsing.length &&
        !operators.contains(parsing[rightIndex])) {
      rightValue += parsing[rightIndex];
      rightIndex++;
    }

    if (leftValue.isEmpty) leftValue = '0';
    if (rightValue.isEmpty) rightValue = '0';

    Map<String, dynamic> result = {
      'leftIndex': leftIndex + 1,
      'rightIndex': rightIndex,
      'leftValue': double.parse(leftValue),
      'rightValue': double.parse(rightValue),
    };

    return result;
  }
}
