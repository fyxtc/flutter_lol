import 'package:flutter/material.dart';
import 'package:my_lol/models/setting_model.dart';
import 'package:my_lol/utils/router.dart' as router;
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    builder: (context) => SettingModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SettingModel settingModel = Provider.of<SettingModel>(context);
    // print(settingModel.list);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.grey[100],
        scaffoldBackgroundColor: Colors.grey[100],
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: router.generateRoute,
      initialRoute: "/",
    );
  }
}
