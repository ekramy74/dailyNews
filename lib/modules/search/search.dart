import 'package:dailynews/layout/cubit/cubit.dart';
import 'package:dailynews/layout/cubit/states.dart';
import 'package:dailynews/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) { var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppCubit.get(context).isdark
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    context: context,
                    controller: searchController,
                    onChange: (value) {
                      NewsCubit.get(context).searchData(value);
                    },
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppCubit.get(context).isdark
                          ? Colors.white
                          : Colors.black,
                    ),
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'you have to enter what you wanna search for';
                      }
                      return null;
                    },
                    label: 'Search',
                    labelstyle: TextStyle(
                        color: AppCubit.get(context).isdark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: AppCubit.get(context).isdark
                            ? FontWeight.w300
                            : FontWeight.normal),
                    prefixiconcolor: AppCubit.get(context).isdark
                        ? Colors.white
                        : Colors.black,
                    prefix: Icons.search,
                  ),
                ),
                Expanded(child: articlebuilder(list, context, isSearch: true ))
              ],
            ),
          );
        });
  }
}
