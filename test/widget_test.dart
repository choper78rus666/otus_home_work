// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_work/controller/globals.dart';
import 'package:home_work/controller/init.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:home_work/controller/auto_router.gr.dart';
import 'package:home_work/configs/recipients.dart';
import 'package:home_work/main.dart';
import 'package:home_work/widgets/favorite.dart';
import 'package:home_work/widgets/recipe_card.dart';
import 'package:home_work/widgets/recipe_detail_page.dart';
import 'package:home_work/widgets/recipients_list.dart';

void main() async {

 await Future.wait([
    //Hive.initFlutter(),
    Init().loadData(),
  ]);

  final Globals globals = Globals();
  final recipeKeys = globals.data['recipeList'].keys.toList();

  group('Тесты:', () {
    /**
     * Тестируем время проставленное в рецепте, 
     * с суммой времени указанного в шагах выполнения.
     * В случае не совпадения выводим ошибку с указанием рецепта.
     */

    // Unit тесты
      recipeKeys.asMap().forEach((key, value) {
        test("Общее время на выполнение рецепта ${globals.data['recipeList'][value].name}", () {

          int counterTime = 0;

          if(recipeList[key]['steps'] != null){

            recipeList[key]['steps'].forEach((val){
              counterTime += val['time'] as int;
            });

          }
          // Транслируем ошибку сравнения времени
          expect(globals.data['recipeList'][value].duration, equals(counterTime));
        });

// Widget тесты
    testWidgets('Тестирование виджета страницы рецепта:', (WidgetTester tester) async {
    globals.data['auth']['status'] = true;

    // Запускаем тест приложения
    /*await tester.pumpWidget(RecipeDetailPage(
    key: UniqueKey(),
    index: key,
    typeCard: 'recipe',
    ));*/
    await tester.pumpWidget(MyApp());
    await tester.pump(const Duration(seconds: 1));
    print("isFavorite ${globals.myVariable[key]['is_favorite']}");

    //final pages = find.byWidget(RecipeList());
    Widget myButton = RecipeCard(typeCard: 'recipe', index: key);
    final slectCard = find.byWidget(myButton);
    expect(slectCard, findsOneWidget);
    await tester.tap(slectCard);
    await tester.pump();
    final favorite = find.byTooltip('Избранное');
    expect(favorite, findsOneWidget);

    await tester.tap(favorite);
    await tester.pump();
    print("isFavorite ${globals.myVariable[key]['is_favorite']}");
    // Verify that our counter starts at 0.
    // expect(find.text('Избранное'), findsOneWidget);
    //expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byWidget(Favorite(index: key,)));
    //await tester.pump();



    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
    });

      });
    
  });
print(recipeKeys);
  recipeKeys.asMap().forEach((key, value) {

  });
}
