import 'package:dailynews/layout/cubit/cubit.dart';
import 'package:dailynews/layout/cubit/states.dart';
import 'package:dailynews/modules/search/search.dart';
import 'package:dailynews/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: AppCubit.get(context).isdark
                    ? Icon(Icons.brightness_2)
                    : Icon(Icons.brightness_2_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
            title: Text('Daily News'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavState(index);
            },
            items: cubit.bottomitems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
