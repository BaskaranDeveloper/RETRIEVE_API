import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //now creating a variable to the data

  late List usersData; //next create a method to get response from web
  final String url =
      "https://breakingbadapi.com/api/characters?limit=10&offset=0";
  bool isLoading = true; //more then two data  we need load .. starting

  Future getData() async {
    //create anothor variable to the web req
    var respons =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    List data = jsonDecode(respons.body);

    setState(() {
      usersData = data;
      isLoading = false; //more then two data  we need load .. ending
    });
  }

  //now creating initState becose we need app load all date using initState
  @override
  void initState() {
    super.initState();
    this.getData(); //get all data using this getData
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TUDO USERS"),
      ),
      body: Container(
        child: Center(
            child: isLoading //if else part
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: usersData == null ? 0 : usersData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Image(
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.contain,
                              image: NetworkImage(usersData[index]['img']),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                usersData[index]['name'],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.all(6.0)),
                              Text("Birthday: ${usersData[index]['birthday']}"),
                            ],
                          ))
                        ]),
                      );
                    },
                  )),
      ),
    );
  }
}
