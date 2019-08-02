import 'package:flutter/material.dart';
import 'package:my_lol/models/hero_simple.dart';
import 'package:my_lol/utils/utils.dart';

class HomeList extends StatefulWidget {
  final List data;
  HomeList({Key key, this.data}) : super(key: key);
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  TextEditingController editingController = TextEditingController();

  List searchResult = null;

  void search(String value){
    value = value.toLowerCase();
    var result = widget.data.where((hero){
      String name = hero["name"];
      name = name.toLowerCase();
      String title = hero["title"];
      title = title.toLowerCase();
      String id = hero["id"];
      id = id.toLowerCase();
      return name.contains(value) || title.contains(value) || id.contains(value);
    }).toList();
    setState(() {
      this.searchResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build >>>>>>>>>>>.");
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          height: 40,
          // padding: EdgeInsets.all(10),
          child: TextField(
            controller: editingController,
            // textAlignVertical: TextAlignVertical.center,
            // textAlign: TextAlign.end,
            // textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
              fontSize: 20
            ),
            onChanged: (value){
              if(value.isEmpty){
                editingController.clear();
                setState(() {
                  searchResult = null;
                });
              }else{
                search(value);
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: (){
                editingController.clear();
                setState(() {
                  searchResult = null;
                });
              },),
              // hintText: "search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
              )
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchResult != null ? searchResult.length : widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              List data = searchResult != null ? searchResult : widget.data;
              return HeroItem(data: HeroSimple.fromJson(data[index]));
            },
          ),
        ),
      ],
    );
  }
}

class HeroItem extends StatefulWidget {
  final HeroSimple data;

  const HeroItem({Key key, this.data}) : super(key: key);
  @override
  _HeroItemState createState() => _HeroItemState();
}

class _HeroItemState extends State<HeroItem> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
        decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: new Offset(0.0, 0.0),
              blurRadius: 6.0,
              spreadRadius: 0.0,
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.grey[50],
        ),
        height: 100,
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        // padding: EdgeInsets.all(30),

        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 35,
              backgroundImage:
                  NetworkImage(Utils.getHeroAvatar(widget.data.image["full"])),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.data.name),
                Text(widget.data.id),
                Text(widget.data.title),
              ],
            ),
          ],
        ));

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'hero_detail', arguments: widget.data);
      },
      child: container
    );
  }
}
