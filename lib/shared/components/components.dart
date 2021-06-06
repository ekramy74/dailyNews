import 'package:dailynews/layout/cubit/cubit.dart';
import 'package:dailynews/modules/webview/webview.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:dailynews/modules/webview/webview.dart';
import 'package:flutter/material.dart';

Widget buildArticlesItem(articles, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(articles['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage('${articles['urlToImage']}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articlebuilder(list, context,{isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticlesItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length),
    fallback: (context) => isSearch? Container() :Center(child: CircularProgressIndicator()));

Widget defaultFormField(
        {@required TextEditingController controller,
        @required TextInputType type,
        Function onSubmit,
        Function onChange,
        Function onTap,
        bool isPassword = false,
        @required Function validate,
        @required String label,
        @required IconData prefix,
        BorderRadius borderRadius,
        BorderSide borderSide,
        OutlineInputBorder outlinedBorder,
        IconData suffix,
        Function suffixPressed,
        bool isClickable = true,
        TextStyle labelstyle,
        Icon outsideicon,
        Color prefixiconcolor,
        context}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        icon: outsideicon,
        labelText: label,
        labelStyle: labelstyle,
        prefixIcon: Icon(
          prefix,
          color: prefixiconcolor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: borderRadius, borderSide: borderSide),
        enabledBorder: OutlineInputBorder(
            borderSide: borderSide, borderRadius: borderRadius),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
