import 'package:flutter/material.dart';
import 'package:home_work/controller/init.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/auto_router.gr.dart';

void main() async {
  await Future.wait([
    Hive.initFlutter(),
    Init().loadData(),
  ]);
  runApp(MyApp());
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Cubic(0.18, -0.15, 0.165, 1.25),
                    ),
                  ),
                  child: child,
                ));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
