import 'package:flutter/material.dart';
import 'package:home_work/globals.dart';

class ExecutionSteps extends StatefulWidget {
  final int index;
  final int step;

  const ExecutionSteps({super.key, required this.index, required this.step});

  @override
  State<ExecutionSteps> createState() => _ExecutionStepsState();
}

class _ExecutionStepsState extends State<ExecutionSteps> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    MyService myService = MyService();
    _isSelected = myService.myVariable[widget.index]['steps'][widget.step] ?? false;
    return Transform.scale(
        scale: 2.5,
        child:Checkbox(
      splashRadius: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      side: const BorderSide(color: Color(0xFF165932), width: 3),
      activeColor: const Color(0xFF165932),
      value: _isSelected,
      tristate: true,
      onChanged: (bool? newValue) {
        if(myService.myVariable[widget.index]['is_started']){
          setState(() {
            _isSelected = newValue!;
            myService.myVariable[widget.index]['steps'][widget.step] = _isSelected;
            print(myService.myVariable);
          });
        }
      },
    ));
  }
}