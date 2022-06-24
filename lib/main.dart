import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_application/global_variables.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*  To post Data to API
    Future postdata() async {
        var res = await http.post(Uri.parse("http://127.0.0.1:8000/posts"),
        body: jsonEncode({"task": "Added Task from Api"}),
        headers: {"Content-type": "application/json"}); */
  /*  To get Data from API
    var res = await http.get(Uri.parse("http://127.0.0.1:8000/posts"));
    */

  /*  To Get Task From Each Object in Array
    var response = jsonDecode(res.body);
    var selectObject = response[1];
    print(selectObject["task"]); */

  dynamic _userTask = TextEditingController();
  List tasks = <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  var example = null;
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
                    postdata();
                    Future.delayed(Duration(milliseconds: 200), () {
                      getdata();
                    });
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
                generateEmptyFunction()
              ],
            ),
          ),
        ));
  }

  generateEmptyFunction() {
    if (example != null) {
      return Expanded(
        child: ListView.builder(
            itemCount: example.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue[200],
                  child: ListTile(
                    //TASKS
                    title: Text('${example[index]["task"]}'),
                    //DELETE BUTTON
                    trailing: IconButton(
                        onPressed: () {
                          deletedata('${example[index]["_id"]}');
                          Future.delayed(Duration(milliseconds: 200), () {
                            getdata();
                          });
                        },
                        icon: Icon(Icons.delete)),
                    dense: false,
                  ),
                ),
              );
            }),
      );
    } else {
      return Text('Please Add a Task');
    }
    return Text('');
  }

  Future postdata() async {
    var post = await http.post(Uri.parse("http://127.0.0.1:8000/posts"),
        body: jsonEncode({"task": "${_userTask.text}"}),
        headers: {"Content-type": "application/json"});
  }

  Future getdata() async {
    var getResponse = await http.get(Uri.parse("http://127.0.0.1:8000/posts"));
    var response = jsonDecode(getResponse.body);
    setState(() {
      example = response;
    });
    print(example);
  }

  Future deletedata(String _id) async {
    var deleteResponse =
        await http.delete(Uri.parse("http://127.0.0.1:8000/posts/${_id}"));
  }
}
/*
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
                              title: Text('Hello'),
                              //DELETE BUTTON
                              trailing: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete)),
                              dense: false,
                            ),
                          ),
                        );
                      }),
                )

                            */

