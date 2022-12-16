import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_work/model/icons/my_icons.dart';

import '../controller/globals.dart';
import 'bottom_navigation.dart';

// Вход / Авторизация
class AuthPage extends StatelessWidget {
  final Globals global = Globals();

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFF2ECC71),
      bottomNavigationBar: BottomNavigation(pageIndex: !global.data['auth']['status'] ? 1 : 3),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 232,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(''),
                  ),
                  const Text(
                    'Otus.Food',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 23),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      prefixIcon: Icon(
                        MyIcons.user,
                        color: Color(0xFFC2C2C2),
                        size: 18,
                      ),
                      hintText: 'логин',
                      hintStyle: TextStyle(
                        color: Color(0xFFC2C2C2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Введите логин';
                    },
                  ),
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFFC2C2C2),
                        size: 18,
                      ),
                      hintText: 'пароль',
                      hintStyle: TextStyle(
                        color: Color(0xFFC2C2C2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Введите пароль';
                    },
                  ),
                  if (global.data['auth']['page'] == 'registration')
                    TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFC2C2C2),
                          size: 18,
                        ),
                        hintText: 'пароль ещё раз',
                        hintStyle: TextStyle(
                          color: Color(0xFFC2C2C2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Введите пароль';
                      },
                    ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF165932)),
                        minimumSize: MaterialStateProperty.all(const Size(232, 48))),
                    child: Text(
                      global.data['auth']['page'] == 'auth' ? "Войти" : "Регистрация",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  //const SizedBox(height: VisualDensity.maximumDensity),
                  Expanded(
                      child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      TextButton(
                        onPressed: () => {},
                        child: Text(global.data['auth']['page'] == 'auth' ? 'Зарегистрироваться' : 'Войти в приложение'),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
