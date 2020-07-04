import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ScreenLoaderClass extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull to Refresh Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserListState();
  }
}

class _UserListState extends State<UserList> {
 


  Widget _buildList() {
    return RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("hola"),
                        )
                      ],
                    ),
                  );
                }),
            onRefresh: _getData,
    );
     
        
  }

  Future<void> _getData() async {
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }
}