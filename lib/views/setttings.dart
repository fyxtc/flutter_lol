import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_lol/models/setting_model.dart';
import 'package:provider/provider.dart';

class SettingItem{
  int id;
  String title;
  bool value;

  SettingItem({this.id, this.title, this.value});
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // SettingModel settingModel = new SettingModel();
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    SettingModel settingModel = Provider.of<SettingModel>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: settingModel.list.map((li){
          return buildItem(li);
        }).toList(),
      )
    );

    // return Consumer<SettingModel>(
    //   builder: (context, setting, child){
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: settingModel.list.map((li){
    //         return buildItem(li);
    //       }).toList(),
    //     );
    //   },
    // );
  }

  Widget buildItem(item){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(item.title),
        SizedBox(width: 10,),
        Container(
          // width: 150,
          child: Switch(
            value: item.value,
            onChanged: (isOn){
              setState(() {
                // list[item.id].value = isOn;
                Provider.of<SettingModel>(context).changeValue(item.id, isOn);
              });
            },
          ),
        )
      ],
    );
  }

}