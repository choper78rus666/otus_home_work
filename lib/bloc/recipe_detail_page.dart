
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailCubit extends Cubit<bool> {

  RecipeDetailCubit() : super(false);

  void executionStepsSelect() => emit(!state);

}