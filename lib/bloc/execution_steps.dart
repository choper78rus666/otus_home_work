import 'package:flutter_bloc/flutter_bloc.dart';

class ExecutionStepsCubit extends Cubit<Map<String, dynamic>> {
  ExecutionStepsCubit() : super({'scale': 2.0, 'isSelected': false});

  void executionStepsSelect() {
    emit({'scale': 2.0, 'isSelected': !state['isSelected']});
  }

  void executionStepsScale() {
    emit({'scale': (state['scale'] == 2.0 ? 3.0 : 2.0), 'isSelected': state['isSelected']});
  }
}
