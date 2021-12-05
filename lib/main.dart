import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// グローバル変数で高さと横を保持
double fieldW=0.0;
double fieldH=0.0;

void main() {
  debugPaintSizeEnabled = false;
  runApp(MaterialApp(
    title: 'Flutter Todo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // 画面サイズの計測を行う
    // 画面の高さはpaddingとAppBarの高さを引く
    Size size = MediaQuery.of(context).size;
    fieldW = size.width;
    var screenHeight = size.height;
    var abovePadding = MediaQuery.of(context).padding.top;
    var appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    fieldH = screenHeight - abovePadding - appBarHeight;

    // var list = ["todo!","todo!","todo!","todo!","todo!","todo!"];
    return TodoMain();
    
  }
}

class TodoMain extends StatefulWidget {
  @override
  _TodoMainState createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  var list = [];
  var flagList = [];
  var todoTitle;
  final TextEditingController _textEditingController = new TextEditingController();
  
  void _addTodoTitle(String title) {
    setState(() {
      list.add(title);
      flagList.add(false);
      _textEditingController.clear();
    });
  }

  // チェックが付いているタスクを削除
  void _removeTodotask() {
    setState(() {
      print(flagList.length);
      for (var i = list.length - 1; i >= 0; i--) {
        print(i);
        print(flagList[i]);
        if (flagList[i] == true) {
          list.removeAt(i);
          flagList.removeAt(i);
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
        actions: [
          ElevatedButton(
            onPressed: () => _removeTodotask(),
            child: const Text(
              "削除",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          )
        ],
      ),
      body: todobody()
    );
  }

  Widget todobody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (list.length <= 9) ? fieldH/10 * list.length + 1 : fieldH/10*9,
            child: titlelist(),
          ),
          addtext(),
          
        ],
      ),
    );
  }

  Widget titlelist() {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int idx) {
          return showlist(list[idx], idx);
        });
  }

  Widget showlist(String title, int idx) {
    return Container(
      height: fieldH/10,
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(color: Colors.grey, width: 3))),
      child: CheckboxListTile(
        title: Container(
          height: 30,
          child: Text(
            title,
            style: (flagList[idx])
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 20,
                    color: Colors.black)
                : TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: flagList[idx],
        onChanged: (value) {
          setState(() {
            flagList[idx] = value;
          });
        },
      ),
    );
  }

  Widget addtext() {
    return Container(
        child: Row(
      children: [
        ElevatedButton(
          onPressed: () => _addTodoTitle(todoTitle),
          child: const Text(
            "登録",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        Expanded(
            child: TextField(
                enabled: true,
                onChanged: (text) {
                  todoTitle = text;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                    )),
                    fillColor: Colors.green[100],
                    filled: true),
                controller: _textEditingController,
            )
      ),
    ],
    ));
  }
}

