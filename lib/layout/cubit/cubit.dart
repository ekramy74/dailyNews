import 'package:dailynews/layout/cubit/states.dart';
import 'package:dailynews/modules/business/business_screen.dart';
import 'package:dailynews/modules/science/science_screen.dart';

import 'package:dailynews/modules/sports/sports_screen.dart';
import 'package:dailynews/network/local/cache_helper.dart';
import 'package:dailynews/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomitems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business_center,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomNavState(int index) {
    currentIndex = index;

    if (index == 1) getSports();
    if (index == 2) getSience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(GetDataLoadingState());

    Diohelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '6a7cdb772ed74868bca965a3919e4dfd'
    }).then((value) {
      // print(value.data['articles'][0]['title'].toString());

      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(GetSportsDataLoadingState());

    if (sports.length == 0) {
      Diohelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sport',
        'apiKey': '6a7cdb772ed74868bca965a3919e4dfd'
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsDataErrorState(error.toString()));
      });
    } else {
      emit(GetSportsDataSuccessState());
    }
  }

  void getSience() {
    emit(GetScienceDataLoadingState());

    if (science.length == 0) {
      Diohelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6a7cdb772ed74868bca965a3919e4dfd'
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(GetScienceDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceDataErrorState(error.toString()));
      });
    } else {
      emit(GetScienceDataSuccessState());
    }
  }

  void searchData(String value) {
    emit(SearchDataLoadingState());

    Diohelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '6a7cdb772ed74868bca965a3919e4dfd'
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(SearchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchDataErrorState(error.toString()));
    });
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isdark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isdark = !isdark;

      CacheHelper.putData(key: 'isDark', value: isdark);
      emit(ChangeAppModeState());
    }
  }
}
