import 'package:dailynews/layout/cubit/cubit.dart';
import 'package:dailynews/layout/cubit/states.dart';
import 'package:dailynews/layout/home_layout.dart';
import 'package:dailynews/network/local/cache_helper.dart';
import 'package:dailynews/network/remote/dio_helper.dart';
import 'package:dailynews/shared/Bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(
    key: 'isDark',
  );

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        )
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.teal[500]),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  actionsIconTheme:
                  IconThemeData(color: Colors.black, size: 25),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  backwardsCompatibility: false,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.teal[500],
                  unselectedIconTheme: IconThemeData(
                    size: 20,
                  ),
                  elevation: 15,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.teal,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.teal[500]),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  actionsIconTheme:
                  IconThemeData(color: Colors.white, size: 25, opacity: .7),
                  elevation: 0,
                  backgroundColor: Colors.black,
                  backwardsCompatibility: false,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w200),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.teal[500],
                  unselectedIconTheme: IconThemeData(
                    size: 20,
                  ),
                  elevation: 15,
                  backgroundColor: Colors.black),
              textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            themeMode:
            AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
            home: Home(),
          );
        },
      ),
    );
  }
}
