import 'parseFormula.dart';

// Старт парсинга формулы, парсер понимает и работает с отрицательными параметрами
void main() {
  // Тест формулы = 36
  String formula = 'x+(-1+(-2+x+(10*5))-(4/2)*y)-1';
  Map<String, double> params = {'x': -10, 'y': -5};

  final getParse = ParseFormula(formula, params);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParse.parseStart());

  formula = '(2/5*2/2*5)';
  final getParse2 = ParseFormula(formula);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParse2.parseStart());

  print("\nТест вывода ошибки в случае лишней скобки");
  formula = '(2/5*2/2*5';
  final getParseError = ParseFormula(formula);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParseError.parseStart());

  print("\nТест деления на 0");
  formula = '2/5*2/0*5';
  final getParseError2 = ParseFormula(formula);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParseError2.parseStart());

/**
 * Формулы предоставленные для теста из задачи
 */
  print("\nФормулы из задачи");
  formula = '10*5+4/2-1';
  final getParse3 = ParseFormula(formula);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParse3.parseStart());

  params = {'x': 10};
  formula = '(x*3-5)/5';
  final getParse4 = ParseFormula(formula, params);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParse4.parseStart());

  formula = '3*x+15/(3+2)';
  final getParse5 = ParseFormula(formula, params);
  // Запуск парсинга и подсчета формулы
  print(formula + ' = ' + getParse5.parseStart());
}
