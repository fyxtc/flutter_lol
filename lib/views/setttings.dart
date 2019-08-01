import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      height: 500,
      child: Stack(
        children: <Widget>[
          // Positioned(
          //   top: 150,
          //   child: Container(color: Colors.blue, width: 100, height: 100,),
          // ),
          // Positioned(
          //   left: 30,
          //   top: 100,
          //   child: Container(color: Colors.red, width: 100, height: 100,),
          // ),
          // Container(color: Colors.black, width: 100, height: 100,),
          Center(
            child: Switch(
              value: _value,
              onChanged: (isOn){
                setState(() {
                  _value = isOn;
                });
                // print("isOn $isOn");
              },
            ),
          ),
        ],
      ),

      // child: Center(child: Text("Settings"),),
    );
  }
}