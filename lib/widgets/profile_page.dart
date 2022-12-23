import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.dart';
import '../controller/globals.dart';
import '../model/icons/my_icons.dart';
import 'bottom_navigation.dart';

class ProfilePage extends StatelessWidget {
  final Globals global = Globals();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      bottomNavigationBar: BottomNavigation(pageIndex: 3),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 396,
            child: Column(
              children: [
                const SizedBox(height: 61),
                Container(
                  width: 122,
                  height: 122,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(61)),
                    border: Border.all(
                      color: const Color(0xFF165932),
                      width: 4,
                    ),
                  ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFFFFFFF)),
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                    ),
                    child: const Icon(
                      color: Color(0xFF2ECC71),
                      MyIcons.user,
                      size: 80,
                    ),
                    onPressed: () {
                      //Todo: смена аватарки
                    },
                  ),
                ),
                const SizedBox(height: 61),
                Container(
                  width: MediaQuery.of(context).size.width > 396 ? 396 : MediaQuery.of(context).size.width - 40,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0X1A959292),
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Логин',
                          style: TextStyle(
                            color: Color(0xFF165932),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          global.data['auth']['user_name'],
                          style: const TextStyle(
                            color: Color(0xFF2ECC71),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width > 396 ? 396 : MediaQuery.of(context).size.width - 40,
                  height: 56,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0X1A959292),
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFFFFFFF)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(232, 48)),
                    ),
                    child: const Text(
                      'Выход',
                      style: TextStyle(
                        color: Color(0XFFF54848),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      global.data['auth']['user_name'] = 'Anonymous';
                      global.data['auth']['user_id'] = 0;
                      global.data['auth']['status'] = false;
                      context.read<StateAuthPageCubit>().changeState();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
