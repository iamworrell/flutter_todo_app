import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getdata() async {
    var res = await http.get(Uri.parse("http://127.0.0.1:8000/posts"));
    print(res.statusCode);
    print(res.body);
    var response = jsonDecode(res.body);
    print(response);
    print('Hello');
  }

  dynamic _userTask = TextEditingController();
  List tasks = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('To-Do App'),
          centerTitle: true,
        ),
        //Body
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _userTask,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Task',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    getdata();
                    tasks.add(_userTask.text);
                    setState(() {});
                    _userTask.clear();
                  },
                  color: Colors.blue[300],
                  child: const Text(
                    'Click To Add Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.blue[200],
                            child: ListTile(
                              //EDIT BUTTON
                              leading: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.settings)),
                              //TASKS
                              title: Text('${tasks[index]}'),
                              //DELETE BUTTON
                              trailing: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete)),
                              dense: false,
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
