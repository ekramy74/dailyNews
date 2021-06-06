import 'package:dailynews/layout/cubit/cubit.dart';
import 'package:dailynews/layout/cubit/states.dart';
import 'package:dailynews/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {var list = NewsCubit.get(context).business;
        return articlebuilder(list, context);
      },
    );
  }
}
