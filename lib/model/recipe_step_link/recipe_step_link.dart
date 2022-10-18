import 'package:hive/hive.dart';

part 'recipe_step_link.g.dart';

@HiveType(typeId: 5)
class RecipeStepLink {
  RecipeStepLink({
    required this.id,
    required this.number,
    required this.recipe,
    required this.step,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  int number;

  @HiveField(2)
  Map<String, int> recipe;

  @HiveField(3)
  Map<String, int> step;
}
