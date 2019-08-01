
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_lol/views/hero_detail.dart';
import 'package:my_lol/views/home.dart';
import 'package:my_lol/views/setttings.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => HomeView());
    case "hero_detail":
      return MaterialPageRoute(builder: (context) => HeroDetail(data: settings.arguments,));
    case "settings":
      return MaterialPageRoute(builder: (context) => Settings());
    default:
      assert(false);
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}