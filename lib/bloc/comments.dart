import 'package:flutter_bloc/flutter_bloc.dart';

// Переключение чекбоксов - шаги выполнения
class CommentsFileUploadCubit extends Cubit<bool> {
  CommentsFileUploadCubit() : super(false);

  void changeState()async => emit(!state);
}

// Просмотр картинок пользователей
class ViewImageSlide extends Cubit<bool> {
  ViewImageSlide() : super(false);

  void changeImage() async => emit(!state);
}