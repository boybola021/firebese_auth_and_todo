import 'package:firebase_auth_and_todo/cubit/todo_cubit/todo_cubit.dart';
import 'package:firebase_auth_and_todo/pages/home_page.dart';
import 'package:firebase_auth_and_todo/services/auth_service.dart';
import 'package:firebase_auth_and_todo/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/auth/auth_cubit.dart';
import '../pages/sign_in_page.dart';
import '../src/user_model.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  String get pages {
    List<UserSRC> list = localRepository.readUser();
    String? email = AuthService.user.email ?? "";
    if (list.isEmpty) {
      return "sign_in_page.dart";
    } else {
      return "home_page.dart";
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
         BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<TodoCubit>(create: (context) => TodoCubit()),
        ],
        child:  ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.dark,
            theme: ThemeData.light(useMaterial3: true),
            initialRoute: pages,
            routes: {
              "sign_in_page.dart": (BuildContext context) => const SignInPage(),
              "home_page.dart":  (BuildContext context) => const HomePage(),
            },
          ),
        ),
    );
  }
}
