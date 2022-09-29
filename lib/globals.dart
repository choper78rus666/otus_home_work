import 'configs/recipients.dart';

// Пользовательские настройки - в будующем будут с БД или с Api

class MyService {
  static final MyService _instance = MyService._internal();

  factory MyService() => _instance;

  // Инициализация
  MyService._internal() {
    _myVariable = recipeList
        .map((value) => {
              'is_favorite': false,
              'is_started': false,
              'steps': ((value['steps'] ?? []).map((valStep) => false).toList())
            })
        .toList();
  }

  List _myVariable = [];

  get myVariable => _myVariable;

  set myVariable(value) => myVariable = value;
}
