import 'package:flutter_bloc/flutter_bloc.dart';

// Переключение избранного
class FavoriteSelectCubit extends Cubit<bool> {
  FavoriteSelectCubit(isFavorite) : super(isFavorite);

  void favoriteSelect() {
    emit(!state);
  }
}