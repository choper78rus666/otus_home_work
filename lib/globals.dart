import 'configs/recipients.dart';

// Пользовательские настройки - в будующем будут с БД или с Api

class Globals {
  static final Globals _instance = Globals._internal();

  factory Globals() => _instance;

  // Инициализация
  Globals._internal() {
    _myVariable = recipeList
        .map((value) => {
              'is_favorite': false,
              'is_started': false,
              'steps':
                  ((value['steps'] ?? []).map((valStep) => false).toList()),
              'comments':  [],
            })
        .toList();

    _data = {
      'recipeList' : {},
      'commentList': {},
      'ingredientList': {},
      'measureUnitList': {},
      'freezerList': {},
      'favoriteList': {},
    };
  }

  List _myVariable = [];
  Map<String, dynamic> _data = {};

  get myVariable => _myVariable;
  get data => _data;

  set myVariable(value) => myVariable = value;
  set data(value) => data = value;
}
