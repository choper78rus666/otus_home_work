import 'package:hive/hive.dart';
import 'package:home_work/model/ingredient/ingredient.dart';

part 'measure_unit.g.dart';

@HiveType(typeId: 9)
class MeasureUnit{
  MeasureUnit({
    required this.id,
    required this.one,
    required this.few,
    required this.many,
    required this.ingredients,
});

  @HiveField(0)
  int id;

  @HiveField(1)
  String one;

  @HiveField(2)
  String few;

  @HiveField(3)
  String many;

  @HiveField(4)
  List<Ingredient> ingredients;

}