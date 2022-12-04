import 'package:flutter_bloc/flutter_bloc.dart';

// Переключение чекбоксов - шаги выполнения
class CommentsFileUploadCubit extends Cubit<bool> {
  CommentsFileUploadCubit() : super(false);

  void changeState()async => emit(!state);
}