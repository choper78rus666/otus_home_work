import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_work/widgets/profile_page.dart';

import '../bloc/auth.dart';
import '../controller/globals.dart';
import 'auth_form.dart';

// Вход / Авторизация
class AuthPage extends StatelessWidget {
  final Globals global = Globals();

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StateAuthPageCubit(),
      child: BlocBuilder<StateAuthPageCubit, bool>(
          builder: (context, authState) =>
              global.data['auth']['status'] ? ProfilePage() : AuthForm()),
    );
  }
}
