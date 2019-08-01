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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return HeroItem(data: HeroSimple.fromJson(widget.data[index]));
        },
      ),
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
