import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:home_work/controller/globals.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:home_work/controller/init.dart';
import 'package:home_work/configs/recipients.dart';
import 'package:home_work/widgets/execution_steps.dart';
import 'package:home_work/widgets/favorite.dart';
import 'package:home_work/widgets/recipe_detail_page.dart';

void main() async {
  await Future.wait([
    //Hive.initFlutter(),
    Init().loadData(),
  ]);

  final Globals globals = Globals();
  final recipeKeys = globals.data['recipeList'].keys.toList();
  // Авторизуем пользователя
  globals.data['auth']['status'] = true;

  group('Тесты:', () {
    /**
     * Тестируем время проставленное в рецепте,
     * с суммой времени указанного в шагах выполнения.
     * В случае не совпадения выводим ошибку с указанием рецепта.
     */

    // Unit тесты - Перебираем все рецепты
    recipeKeys.asMap().forEach((key, value) {
      test("Общее время на выполнение рецепта ${globals.data['recipeList'][value].name}", () {
        int counterTime = 0;

        if (recipeList[key]['steps'] != null) {
          recipeList[key]['steps'].forEach((val) {
            counterTime += val['time'] as int;
          });
        }
        // Транслируем ошибку сравнения времени
        expect(globals.data['recipeList'][value].duration, equals(counterTime));
      });

      // Widget тесты страниц рецептов
      testWidgets("Тестирование наличия основных блоков виджета страницы рецепта  ${globals.data['recipeList'][value].name}:", (WidgetTester tester) async {
        // Запускаем страницы рецепта
        RecipeDetailPage(
          key: UniqueKey(),
          index: key,
          typeCard: 'recipe',
        );
        await tester.pumpWidget(MaterialApp(
          home: Material(
            child: RecipeDetailPage(
              key: UniqueKey(),
              index: key,
              typeCard: 'recipe',
            ),
          ),
        ));

        expect(find.byType(AppBar), findsWidgets);
        expect(find.text('Рецепт'), findsWidgets);
        expect(find.byType(Favorite), findsWidgets);
        expect(find.byTooltip('Избранное'), findsWidgets);
        expect(find.byType(CachedNetworkImage), findsWidgets);
        expect(find.text('Ингредиенты'), findsWidgets);
        await tester.pump(const Duration(seconds: 2));
        final start = find.text('Начать готовить');
        await tester.scrollUntilVisible(start, 700);
        expect(start, findsWidgets);
        expect(find.byType(StartProcess), findsWidgets);
      });

      testWidgets("Тестирование нажатия на кнопку избранное виджета страницы рецепта  ${globals.data['recipeList'][value].name}:", (WidgetTester tester) async {
        // Запускаем страницы рецепта
        RecipeDetailPage(
          key: UniqueKey(),
          index: key,
          typeCard: 'recipe',
        );

        // Тест нажатия на избранное
        globals.myVariable[key]['is_favorite'] = false;

        print("isFavorite ${globals.myVariable[key]['is_favorite']}");

        await tester.pumpWidget(MaterialApp(
          home: Material(
            child: Favorite(
              index: key,
            ),
          ),
        ));

        expect(find.byTooltip('Избранное'), findsWidgets);
        final favorite = find.byType(IconButton);
        await tester.tap(favorite);
        await tester.pump(const Duration(seconds: 2));
        expect(find.byTooltip('В избранном'), findsWidgets);
        expect(globals.myVariable[key]['is_favorite'], isTrue);

        print("isFavorite ${globals.myVariable[key]['is_favorite']}");
      });

      testWidgets("Тестирование шагов выполнения виджета страницы рецепта  ${globals.data['recipeList'][value].name}:", (WidgetTester tester) async {
        // Проверяем шаги приготовления
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: StartProcess(
                index: key,
              ),
            ),
          ),
        );

        print('Started ${globals.myVariable[key]['is_started']}');
        await tester.pump(const Duration(seconds: 2));
        final start = find.text('Начать готовить');
        expect(start, findsWidgets);
        await tester.scrollUntilVisible(start, 10);
        await tester.tap(start);
        await tester.pump(const Duration(seconds: 2));
        expect(find.text('Закончить готовить'), findsWidgets);

        // Выводим статус активноти шагов выполнение
        print('Started ${globals.myVariable[key]['is_started']}');
        print('Steps checked: ${globals.myVariable[key]['steps']}');

        if (recipeList[key]['steps'] != null) {
          for (int nextStep = 0; nextStep < recipeList[key]['steps'].length; nextStep++) {
            final startSteps = find.byKey(Key('Step $nextStep'));
            expect(startSteps, findsWidgets);
            await tester.scrollUntilVisible(startSteps, 10);
            await tester.tap(startSteps);
            await tester.pump(const Duration(seconds: 2));
            final checkbox = tester.firstWidget(startSteps) as Checkbox;
            expect(checkbox.value, true);
          }
          // Выводим итоговый статус активноти шагов выполнение
          print('Steps checked: ${globals.myVariable[key]['steps']}');
        }
      });
    });
  });
}
