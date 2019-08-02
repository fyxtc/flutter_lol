import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier{
  List<SettingItem> list = [
    SettingItem(id: 1, title: "设置1", value: false),
    SettingItem(id: 2, title: "设置2", value: false),
    SettingItem(id: 3, title: "设置3", value: false),
  ];

  changeValue(id, value){
    list[id - 1].value = value;
    notifyListeners();
  }

  
} 

class SettingItem{
  int id;
  String title;
  bool value;

  SettingItem({this.id, this.title, this.value});

}