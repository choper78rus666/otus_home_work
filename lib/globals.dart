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
  }

  List _myVariable = [];

  get myVariable => _myVariable;

  set myVariable(value) => myVariable = value;
}
