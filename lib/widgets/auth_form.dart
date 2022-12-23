// Форма авторизации
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.dart';
import '../controller/globals.dart';
import '../model/icons/my_icons.dart';
import 'bottom_navigation.dart';

class AuthForm extends StatelessWidget {
  final Globals global = Globals();

  AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String login = '';
    String password = '';
    String repassword = '';

    return BlocProvider(
      create: (_) => StateAuthUserCubit(),
      child: BlocBuilder<StateAuthUserCubit, bool>(
        builder: (context, isAuth) => Scaffold(
          backgroundColor: const Color(0xFF2ECC71),
          bottomNavigationBar: BottomNavigation(pageIndex: 1),
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: 232,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(''),
                      ),
                      const Text(
                        'Otus.Food',
                        style:
                            TextStyle(color: Color(0xFFFFFFFF), fontSize: 23),
                      ),
                      const Expanded(
                          child: SizedBox(
                        height: 80.0,
                      )),
                      TextFormField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
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
                          if (value == null || value.isEmpty) {
                            return 'Введите логин';
                          }
                          login = value;
                          return null;
                        },
                      ),
                      TextFormField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
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
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          password = value;
                          return null;
                        },
                      ),
                      if (!isAuth)
                        TextFormField(
                          maxLength: 20,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
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
                            if (value == null || value.isEmpty) {
                              return 'Введите пароль';
                            }
                            if (value != password) {
                              return 'Пароли не совпадают';
                            } else {
                              repassword = value;
                            }
                            return null;
                          },
                        ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF165932)),
                          minimumSize:
                              MaterialStateProperty.all(const Size(232, 48)),
                        ),
                        child: Text(
                          isAuth ? "Войти" : "Регистрация",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // TODO: нужна проверка авторизации
                            global.data['auth']['user_name'] = login;
                            global.data['auth']['status'] = true;

                            print(login);
                            print(password);
                            print(repassword);
                            context.read<StateAuthPageCubit>().changeState();
                            //BlocProvider.of<StateAuthPageCubit>(context).changeState();
                          }
                        },
                      ),
                      //const SizedBox(height: VisualDensity.maximumDensity),
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.read<StateAuthUserCubit>().changeState();
                              },
                              child: Text(
                                isAuth
                                    ? 'Зарегистрироваться'
                                    : 'Войти в приложение',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
