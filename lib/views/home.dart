import 'package:flutter/material.dart';
import 'package:my_lol/utils/constant.dart';
import 'package:my_lol/utils/utils.dart';
import 'package:my_lol/views/home_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:my_lol/views/setttings.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<dynamic> heroList = [];
  int _selectedIndex = 0;
  String _searchString;
  bool isSearching  = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 6);
    init();
  }

  init() async {
    Map res = await getHeroList();
    setState(() {
      heroList = res.values.toList();
      // print("fuck >>>>>>>>>>>>>>>>>>");
      // print(res.values.toList());
    });
  }

  getHeroList() async {
    var res = await http.get('http://47.52.142.157:3002/hero');
    if (res.statusCode == 200) {
      return convert.jsonDecode(res.body)['data'];
    } else {
      print("Request failed with status: ${res.statusCode}.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Column(children: <Widget>[
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         width: 200,
        //         height: 20,
        //         child: TextField(
        //           onChanged: (string){
        //             _searchString = string;
        //           },
        //           onSubmitted: (string){
        //             print("search $string");
        //           },
        //           decoration: InputDecoration(
        //               // hintText: "search here",
        //               enabledBorder: OutlineInputBorder(
        //                   borderSide:
        //                       BorderSide(width: 1, color: Colors.white)),
        //               focusedBorder: OutlineInputBorder(
        //                   borderSide:
        //                       BorderSide(width: 1, color: Colors.white)),
        //               fillColor: Colors.white),
        //         ),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.search),
        //         onPressed: () {
        //           print("search $_searchString");
        //         },
        //       )
        //     ],
        //   )
        // ]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("search $_searchString");
              setState(() {
                isSearching = true;
              });
            },
          )
        ],
        title: _selectedIndex == 1
            ? Text("Settings")
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(text: '战士'),
                  Tab(text: '坦克'),
                  Tab(text: '法师'),
                  Tab(text: '刺客'),
                  Tab(text: '辅助'),
                  Tab(text: '射手'),
                ],
              ),
      ),
      body: _selectedIndex == 1
          ? Settings() // Center( child: Text("Settings"),)
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Fighter)),
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Tank)),
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Mage)),
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Assassin)),
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Support)),
                HomeList(data: Utils.filterHeroByTag(heroList, Tags.Marksman)),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              title: Text("Settings"), icon: Icon(Icons.settings)),
        ],
        // 这里必须初始化_selectedIndex值，不能为null，否则会报错“NoSuchMethodError: The method '>' was called on null”
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // if(index == 1){
            //   Navigator.pushNamed(context, "settings");
            // }
          });
        },
      ),
    );
  }
}
