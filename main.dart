// Матматические операции
class CalcFunc {

  // Считаем умножение
  String calcMultiply(parsing){

    int lastIndex = 0;

    do{

      lastIndex = parsing.lastIndexOf('*');

      if(lastIndex != -1){

        int negative = 1;

        // Проверка второго множителя на отрицательное число
        if(parsing[lastIndex + 1] == '-') {
          parsing = parsing.replaceRange(lastIndex + 1, lastIndex + 2, '');
          negative = -1;
        }

        Map<String, dynamic> leftRightVal = this.leftRightVal(parsing, lastIndex);
        double newValue = leftRightVal['leftValue'] * leftRightVal['rightValue'] * negative;

        //Проверка на оператор вычитания перед первым числом
        if(leftRightVal['leftIndex'] >= 1 && parsing[leftRightVal['leftIndex']-1] == '-' && newValue < 0) {
          newValue *= -1;
          parsing = parsing.replaceRange(leftRightVal['leftIndex']-1, leftRightVal['leftIndex'], '+');
        }
        //Проверка на оператор сложения перед первым числом
        else if(leftRightVal['leftIndex'] >= 1 && parsing[leftRightVal['leftIndex']-1] == '+' && newValue < 0) {
          leftRightVal['leftIndex'] -= 1;
        }

        parsing = parsing.replaceRange(leftRightVal['leftIndex'], leftRightVal['rightIndex'], newValue.toString());
      }

    } while(lastIndex != -1);

    return parsing;
  }

  // Считаем деление
  String calcDivide(parsing){

    int lastIndex = 0;

    do{

      lastIndex = parsing.lastIndexOf('/');

      if(lastIndex != -1){

        int negative = 1;

        // Проверка второго делителя на отрицательное число
        if(parsing[lastIndex + 1] == '-') {
          parsing = parsing.replaceRange(lastIndex + 1, lastIndex + 2, '');
          negative = -1;
        }

        Map<String, dynamic> leftRightVal = this.leftRightVal(parsing, lastIndex);
        double newValue = leftRightVal['leftValue'] / leftRightVal['rightValue'] * negative;

        //Проверка на оператор вычитания перед первым числом
        if(leftRightVal['leftIndex'] >= 1 && parsing[leftRightVal['leftIndex']-1] == '-' && newValue < 0) {
          newValue *= -1;
          parsing = parsing.replaceRange(leftRightVal['leftIndex']-1, leftRightVal['leftIndex'], '+');
        }

        //Проверка на оператор сложения перед первым числом
        else if(leftRightVal['leftIndex'] >= 1 && parsing[leftRightVal['leftIndex']-1] == '+' && newValue < 0) {
          leftRightVal['leftIndex'] -= 1;
        }

        parsing = parsing.replaceRange(leftRightVal['leftIndex'], leftRightVal['rightIndex'], newValue.toString());
      }

    } while(lastIndex != -1);

    return parsing;
  }

  // Считаем сложение
  String calcSum(parsing){

    int lastIndex = 0;

    do{

      lastIndex = parsing.lastIndexOf('+');

      if(lastIndex != -1){

        Map<String, dynamic> leftRightVal = this.leftRightVal(parsing, lastIndex);

        //Проверка на отрицательное первое число
        if(leftRightVal['leftIndex'] == 1 && parsing[0] == '-') {
          leftRightVal['leftValue'] *= -1;
          leftRightVal['leftIndex'] = 0;
        }

        double newValue = leftRightVal['leftValue'] + leftRightVal['rightValue'];
        parsing = parsing.replaceRange(leftRightVal['leftIndex'], leftRightVal['rightIndex'], newValue.toString());
      }

    } while(lastIndex != -1);

    return parsing;
  }

  // Считаем вычитание
  String calcDiff(parsing){

    int lastIndex = 0;

    do{

      lastIndex = parsing.lastIndexOf('-');

      if(lastIndex > 0){

        Map<String, dynamic> leftRightVal = this.leftRightVal(parsing, lastIndex);

        //Проверка на отрицательное первое число
        if(leftRightVal['leftIndex'] >= 1 && parsing[leftRightVal['leftIndex']-1] == '-') {
          leftRightVal['leftValue'] *= -1;
          leftRightVal['leftIndex'] -= 1;
        }

        double newValue = leftRightVal['leftValue'] - leftRightVal['rightValue'];
        parsing = parsing.replaceRange(leftRightVal['leftIndex'], leftRightVal['rightIndex'], newValue.toString());
      }

    } while(lastIndex > 0);

    return parsing;
  }

  // Собираем значения с лева и справа от оператора вычисления
  Map<String, dynamic> leftRightVal(String parsing, int lastIndex){

    int leftIndex = lastIndex - 1;
    int rightIndex = lastIndex + 1;
    String leftValue = '';
    String rightValue = '';
    var operators = ['(',')','+','-','*','/'];

    while(leftIndex >= 0 && !operators.contains(parsing[leftIndex])){
      leftValue = parsing[leftIndex] + leftValue;
      leftIndex--;
    }

    while(rightIndex < parsing.length && !operators.contains(parsing[rightIndex])){
      rightValue += parsing[rightIndex];
      rightIndex++;
    }

    if(leftValue.isEmpty) leftValue = '0';
    if(rightValue.isEmpty) rightValue = '0';

    Map<String, dynamic> result = {
      'leftIndex' : leftIndex+1,
      'rightIndex' : rightIndex,
      'leftValue' : double.parse(leftValue),
      'rightValue' : double.parse(rightValue),
    };

    return result;

  }
}

// Основной класс для обработки формулы
class ParseFormula {

  String formula;

  ParseFormula(this.formula, [params = null]){

    // Прверяем на входе конструкора наличие параметров для фрмулы
    if(params != null) {

      for(var param in params.entries){
        this.formula = this.formula.replaceAll(param.key, param.value.toString());
      }

      // Обрабатываем возможные двойные операторы, после замены отрицательных параметров
      this.formula = this.formula.replaceAll('--', '+');
      this.formula = this.formula.replaceAll('+-', '-');
    }
  }

  // Основной метод запуска парсинга
  String parseStart([String parseStr = '']){

    if(parseStr.isEmpty) parseStr = this.formula;
    int lastIndex = 0;
    int lastIndexRight = 0;

    do{

      lastIndex = parseStr.lastIndexOf('(');

      if(lastIndex != -1) {

        lastIndexRight = parseStr.indexOf(')', lastIndex);
        String newStr = this.parseStart(parseStr.substring(lastIndex + 1, lastIndexRight));
        parseStr =  parseStr.replaceRange(lastIndex, lastIndexRight + 1, newStr);

        //Проверка на наличие операторов перед первым числом, если расчиталось отрицательное
        if(lastIndex > 0 && (parseStr[lastIndex-1] == '-' || parseStr[lastIndex-1] == '+') && double.parse(newStr) < 0) {

          parseStr = parseStr.replaceRange(lastIndex,lastIndex + 1, '');

          if(parseStr[lastIndex-1] == '+') parseStr = parseStr.replaceRange(lastIndex-1,lastIndex, '-');
           else if(parseStr[lastIndex-1] == '-') parseStr = parseStr.replaceRange(lastIndex-1,lastIndex, '+');
        }
      }
    } while(lastIndex != -1);

    CalcFunc calcFunc = CalcFunc();
    parseStr = calcFunc.calcMultiply(parseStr);
    parseStr = calcFunc.calcDivide(parseStr);
    parseStr = calcFunc.calcDiff(parseStr);
    parseStr = calcFunc.calcSum(parseStr);

    return parseStr;
  }
}

// Старт парсинга формулы, парсер понимает и работает с отрицательными параметрами
void main(){

  String formula = 'x+(-1+(-2+x+(10*5))-(4/2)*y)-1';
  Map<String, double> params = {
    'x' : -10,
    'y' : -5
  };

  print(formula);
  final getParse = ParseFormula(formula, params);

  // Запуск парсинга и подсчета формулы
  print(getParse.parseStart());

}