import 'package:flutter_bloc/flutter_bloc.dart';

// Переключение вход / авторизация
class StateAuthPageCubit extends Cubit<bool> {
  StateAuthPageCubit() : super(false);

  void changeState() async => emit(!state);
}

// Переключение вход / logout
class StateAuthUserCubit extends Cubit<bool> {
  StateAuthUserCubit() : super(true);

  void changeState() async => emit(!state);
}
