import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var list = ["todo!","todo!","todo!","todo!","todo!","todo!"];
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('todo'),
        ),
        body: TodoMain(),
        /*body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index >= list.length) {
              list.addAll(["todo_add", "todo_add"]);
            }
            return _menuItem(list[index]);
          }
        ),*/
      ),
    );
  }
  /*
  Widget _menuItem(String title) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border(bottom: BorderSide(width:1.0, color: Colors.grey))
      ),
      child: ListTile(
        title:  Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0
          ),
        ),
        onTap: (){
          print("ontap called.");
        },
        onLongPress: (){
          print("on long tap called");
        },
      )
    );
  }
  */
}

class TodoMain extends StatefulWidget {
  @override
  _TodoMainState createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  var list = [];
  var flagList = [];
  var todoTitle;

  void _addTodo() {
    setState(() {
      list.add("todo!!!");
    });
  }

  void _addTodoTitle(String title) {
    setState(() {
      list.add(title);
      flagList.add(false);
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: titlelist()),
        addtext(),
        FloatingActionButton(
          onPressed: _addTodo,
          child: Icon(Icons.add),
        ),
      ],
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
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(color: Colors.grey, width: 3))),
      child: CheckboxListTile(
        title: Text(
          title,
          style: (flagList[idx])
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 20,
                  color: Colors.black)
              : TextStyle(fontSize: 20, color: Colors.black),
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
        child: Column(
      children: [
        TextField(
            enabled: true,
            onChanged: (text) {
              todoTitle = text;
            }),
        ElevatedButton(
          onPressed: () => _addTodoTitle(todoTitle),
          child: const Text(
            "登録",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        )
      ],
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
