import 'package:flutter/material.dart';
import 'package:collins_vocabulary/components/selectBook.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/ChangePlan.dart';

class Mine extends StatefulWidget {
  SharedPreferences prefs;
  Mine({Key key,this.prefs}) : super(key:key);

  @override
  MineState createState() => new MineState();
}

class MineState extends State<Mine> {
  bool showColins;
  bool AutoSound;
  bool Sentence;
  bool showCn;
  bool en_ph;
  int count;
  @override
  void initState() {
    super.initState();
    showColins = widget.prefs.getBool('showcollins');
    Sentence = widget.prefs.getBool('sentence');
    showCn = widget.prefs.getBool('showCn');
    AutoSound = widget.prefs.getBool('autoplay');
    count = widget.prefs.getInt('count');
    en_ph = widget.prefs.getBool('en_ph');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('assets/img/mine.jpeg'),
                )
            ),
            padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 16.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(6.0),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage('assets/img/account.jpeg'),
                      )
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(left: 12.0)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Neil',style: new TextStyle(fontSize: 26.0,color: Colors.amberAccent),),
                    new Text('已连续学习30天',style: new TextStyle(fontSize: 14.0,color: Colors.white70),),
                  ],
                )
              ],
            ),
          ),
          new Expanded(
              child: new ListView(
                children: <Widget>[
                  new InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (context) => new SelectBook(prefs:widget.prefs)
                          )
                      );
                    },
                    child: new Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('切换单词书',style: new TextStyle(fontSize: 16.0),),
                            new Icon(Icons.chevron_right,size: 30.0,color: Colors.grey)
                          ],
                        )
                    ),
                  ),
                  new InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (context) => new ChangePlan(prefs:widget.prefs)
                          )
                      );
                      setState((){
                        count = widget.prefs.getInt('count');
                      });
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text('当前复习计划：每天${count}个单词',style: new TextStyle(fontSize: 16.0),),
                          new Icon(Icons.chevron_right,size: 30.0,color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                  new CheckboxListTile(
                    activeColor: Colors.blueGrey,
                    dense: false,
                    title: const Text('英式发音'),
                    value: en_ph,
                    onChanged: (bool value) { setState(() {
                      en_ph = value;
                      widget.prefs.setBool('en_ph', value);
                    }); },
                  ),
                  new CheckboxListTile(
                    activeColor: Colors.blueGrey,
                    dense: false,
                    title: const Text('美式发音'),
                    value: !en_ph,
                    onChanged: (bool value) { setState(() {
                      en_ph = !value;
                      widget.prefs.setBool('en_ph', !value);
                    }); },
                  ),
                  new SwitchListTile(
                      activeColor: Colors.blueGrey,
                      title: new Text('自动播放发音'),
                      value: AutoSound,
                      onChanged: (bool value) {
                        setState((){
                          AutoSound = value;
                          widget.prefs.setBool('autoplay', value);
                        });
                      }
                  ),
                  new SwitchListTile(
                      activeColor: Colors.blueGrey,
                      title: new Text('开启柯林斯词典'),
                      value: showColins,
                      onChanged: (bool value) {
                        setState((){
                          showColins = value;
                          widget.prefs.setBool('showcollins', value);
                        });
                      }
                  ),
                  new SwitchListTile(
                      activeColor: Colors.blueGrey,
                      title: new Text('显示中文翻译'),
                      value: showCn,
                      onChanged: (bool value) {
                        setState((){
                          showCn = value;
                          widget.prefs.setBool('showCn', value);
                        });
                      }
                  ),
                  new SwitchListTile(
                      activeColor: Colors.blueGrey,
                      title: new Text('显示例句'),
                      value: Sentence,
                      onChanged: (bool value) {
                        setState((){
                          Sentence = value;
                          widget.prefs.setBool('sentence', value);
                        });
                      }
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}