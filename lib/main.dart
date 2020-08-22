import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}

//リスト一覧画面Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  //Todoリストのデータ
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //"push"で新規画面に遷移
          //リスト追加画面から渡されるデータを受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              //遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            //キャンセルした場合は　newListText がnullとなる
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  //入力されたテキストをデータとしてもつ
  String _text = '';

  //データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('リスト追加'),
        ),
        body: Container(
            padding: EdgeInsets.all(64),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_text,
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextField(
                    //入力されたテキストの値を受け取る
                    onChanged: (String value) {
                      // データが変更したことを知らせる（画面を更新する）
                      setState(() {
                        // データを変更
                        _text = value;
                      });
                    },
                  ),
                  Container(
                    // 横幅いっぱいに広げる
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pop(_text);
                      },
                      child: Text(
                        'リスト追加',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    //キャンセルボタン
                    child: FlatButton(
                      color: Colors.blueGrey[200],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'キャンセル',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ])));
  }
}
