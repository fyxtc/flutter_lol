import 'package:flutter/material.dart';
import 'package:my_lol/models/hero_detail.dart';
import 'package:my_lol/models/hero_simple.dart';
import 'package:http/http.dart' as http;
import 'package:my_lol/utils/constant.dart';
import 'dart:convert' as convert;

import 'package:my_lol/utils/utils.dart';

class HeroDetail extends StatefulWidget {
  final HeroSimple data;

  const HeroDetail({Key key, this.data}) : super(key: key);
  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  bool _loading;
  HeroDetailModel _heroData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    initData();
  }

  void initData() async {
    Map res = await getHeroDetail(widget.data.id);
    print(res["data"]);
    setState(() {
      _heroData = HeroDetailModel.fromJson(res["data"]);
      _loading = false;
    });
  }

  getHeroDetail(id) async {
    var res = await http.get('http://47.52.142.157:3002/hero/$id');
    if (res.statusCode == 200) {
      return convert.jsonDecode(res.body);
    } else {
      print("Request failed with status: ${res.statusCode}.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                child: Column(
                  children: <Widget>[

                    Container(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(
                                Utils.getHeroSkin(_heroData.skins[0]["id"])),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: widget.data.name,
                                    style: TextStyle(color: Colors.blue)),
                                TextSpan(
                                    text: " - ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: widget.data.title,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                      // margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    ),
                    DetailItem(
                      title: "类型",
                      child: Row(
                        children: widget.data.tags.map((tag){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              radius: 30,
                              child: Text(TagsMap[tag]),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    DetailItem(
                      title: "属性",
                      child: Column(
                        children: [
                          InfoItem(
                            title: "物理攻击",
                            value: _heroData.info.attack,
                          ),
                          InfoItem(
                            title: "魔法攻击",
                            value: _heroData.info.magic,
                          ),
                          InfoItem(
                            title: "防御能力",
                            value: _heroData.info.defense,
                          ),
                          InfoItem(
                            title: "上手难度",
                            value: _heroData.info.difficulty,
                          ),
                        ],
                      ),
                    ),
                    DetailItem(
                      title: "技能",
                      child: Column(
                          children: _heroData.spells.map((spell) {
                        int index = _heroData.spells.indexOf(spell);
                        List<String> shortcuts = ["Q", "W", "E", "R"];
                        print("index $index");
                        String title = spell["id"];
                        String content = spell["description"];
                        return SpellItem(
                            title: title,
                            content: content,
                            shortcut: shortcuts[index]);
                      }).toList()),
                    ),
                    DetailItem(
                      title: "人物介绍",
                      child: Text(_heroData.lore),
                    ),
                    DetailItem(
                      title: "使用技巧",
                      child: Text(_heroData.allytips[0]),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailItem({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                color: Colors.green,
                width: 4,
                child: Text(""),
                // margin: EdgeInsets.only(left: 10),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.red, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          child
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final int value;
  const InfoItem({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(title),
          SizedBox(width: 10,),
          Expanded(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.purple),
              value: value / 10,
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(width: 10,),
          Text(value.toString()),
          SizedBox(width: 10,)
        ],
      ),      
    );
  }
}

class SpellItem extends StatelessWidget {
  final String title;
  final String content;
  final String shortcut;

  const SpellItem({Key key, this.title, this.content, this.shortcut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(Utils.getHeroSpell(title)),
              SizedBox(
                width: 10,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  Text(
                    shortcut,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(content),
        ],
      ),
    );
  }
}
