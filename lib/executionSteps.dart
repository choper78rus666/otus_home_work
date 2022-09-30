import 'package:flutter/material.dart';
import 'package:home_work/globals.dart';
import 'configs/recipients.dart';

// Шаги приготовления

class StartProcess extends StatefulWidget {
  final int index;

  const StartProcess({super.key, required this.index});

  @override
  State<StartProcess> createState() => _StartProcessState();
}

class _StartProcessState extends State<StartProcess> {
  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    bool isStarted = globals.myVariable[widget.index]['is_started'] ?? false;
    int nextStep = 0;

    return Column(children: [
      // Собираем чекбоксы
      ...(recipeList[widget.index]['steps'] == null
          ? []
          : recipeList[widget.index]['steps']
              .map(
                (value) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isStarted
                          ? const Color.fromARGB(38, 46, 204, 113)
                          : const Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              (nextStep + 1).toString(),
                              style: TextStyle(
                                fontSize: 40,
                                color: isStarted
                                    ? const Color(0xFF2ECC71)
                                    : const Color(0xFFC2C2C2),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            value['description'],
                            style: TextStyle(
                              fontSize: 12,
                              color: isStarted
                                  ? const Color(0xFF2D490C)
                                  : const Color(0xFF797676),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ExecutionSteps(
                                    index: widget.index, step: nextStep++),
                                Text(
                                  (value['time'] ?? '0')
                                      .toString()
                                      .padLeft(2, '0')
                                      .padLeft(3, '00:'),
                                  softWrap: false,
                                  style: TextStyle(
                                    height: 0.8,
                                    fontSize: 13,
                                    color: isStarted
                                        ? const Color(0xFF165932)
                                        : const Color(0xFF797676),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
      // Кнопка начала приготовления, перерисовывает чекбоксы
      Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 232,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                  color: const Color(0xFF165932),
                  width: 3,
                ),
              ),
              child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    backgroundColor: MaterialStateProperty.all(isStarted
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF165932)),
                    minimumSize:
                        MaterialStateProperty.all(const Size(232, 48))),
                child: Text(
                  (isStarted ? "Закончить готовить" : "Начать готовить"),
                  style: TextStyle(
                    fontSize: 16,
                    color: isStarted
                        ? const Color(0xFF165932)
                        : const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  globals.myVariable[widget.index]['is_started'] = !isStarted;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

// Выводим чекбоксы, под влиянием кнопки Начать готовить
class ExecutionSteps extends StatefulWidget {
  final int index;
  final int step;

  const ExecutionSteps({super.key, required this.index, required this.step});

  @override
  State<ExecutionSteps> createState() => _ExecutionStepsState();
}

class _ExecutionStepsState extends State<ExecutionSteps> {
  @override
  Widget build(BuildContext context) {
    Globals globals = Globals();
    bool isSelected =
        globals.myVariable[widget.index]['steps'][widget.step] ?? false;
    bool isStarted = globals.myVariable[widget.index]['is_started'] ?? false;

    return Transform.scale(
      scale: 2,
      child: Checkbox(
        splashRadius: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        side: BorderSide(
            color:
                (isStarted ? const Color(0xFF165932) : const Color(0xFF797676)),
            width: 3),
        activeColor:
            isStarted ? const Color(0xFF165932) : const Color(0xFF797676),
        value: isSelected,
        tristate: true,
        onChanged: (bool? newValue) {
          if (isStarted) {
            setState(() {
              isSelected = newValue!;
              globals.myVariable[widget.index]['steps'][widget.step] =
                  isSelected;
            });
          }
        },
      ),
    );
  }
}
