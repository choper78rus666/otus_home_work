import 'calcFunc.dart';

// Основной класс для обработки формулы
class ParseFormula {
  String formula;

  ParseFormula(this.formula, [params = null]) {
    // Прверяем на входе конструкора наличие параметров для фрмулы
    if (params != null) {
      for (var param in params.entries) {
        this.formula =
            this.formula.replaceAll(param.key, param.value.toString());
      }

      // Обрабатываем возможные двойные операторы, после замены отрицательных параметров
      this.formula = this.formula.replaceAll('--', '+');
      this.formula = this.formula.replaceAll('+-', '-');
    }

    // Сразу на входе чистим от лишних пробелов
    this.formula = this.formula.replaceAll(' ', '');
  }

  // Основной метод запуска парсинга, рекурсивно разибает формулу по скобкам и возвращает результат вычисления
  String parseStart([String parseStr = '']) {
    if (parseStr.isEmpty) parseStr = this.formula;
    int lastIndex = 0;
    int lastIndexRight = 0;

    // Простая проверка на отсутствие закрывающих скобок
    if ('('.allMatches(parseStr).length != ')'.allMatches(parseStr).length) {
      return 'Нет закрывающей скобки в формуле';
    }

    do {
      lastIndex = parseStr.lastIndexOf('(');

      if (lastIndex != -1) {
        lastIndexRight = parseStr.indexOf(')', lastIndex);

        // Рекурсия, до тех пор пока не останется строки без скобок
        String newStr =
            this.parseStart(parseStr.substring(lastIndex + 1, lastIndexRight));
        parseStr = parseStr.replaceRange(lastIndex, lastIndexRight + 1, newStr);

        //Проверка на наличие операторов перед первым числом, если расчиталось отрицательное
        if (lastIndex > 0 &&
            (parseStr[lastIndex - 1] == '-' ||
                parseStr[lastIndex - 1] == '+') &&
            double.parse(newStr) < 0) {
          parseStr = parseStr.replaceRange(lastIndex, lastIndex + 1, '');

          if (parseStr[lastIndex - 1] == '+')
            parseStr = parseStr.replaceRange(lastIndex - 1, lastIndex, '-');
          else if (parseStr[lastIndex - 1] == '-')
            parseStr = parseStr.replaceRange(lastIndex - 1, lastIndex, '+');
        }
      }
    } while (lastIndex != -1);

    CalcFunc calcFunc = CalcFunc();
    parseStr = calcFunc.calcDivide(parseStr);
    parseStr = calcFunc.calcMultiply(parseStr);
    parseStr = calcFunc.calcDiff(parseStr);
    parseStr = calcFunc.calcSum(parseStr);

    return parseStr;
  }
}
