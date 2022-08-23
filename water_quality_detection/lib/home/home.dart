// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:water_quality_detection/Animation/FadeAnimation.dart';
import 'package:water_quality_detection/home/ph_readings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getMethod() async {
    String theUrl = "https://unfamiliar-hunts.000webhostapp.com/getData.php";
    var res = await http
        .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responsBody = await jsonDecode(res.body);
    print(responsBody);

    return responsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Detection'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ]),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        child: FutureBuilder(
            future: getMethod(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List snap = [snapshot.data];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error Fetching data'),
                );
              }

              return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  return FadeAnimation(
                    5,
                    Container(
                        child: Container(
                            child: Card(
                                child: ListTile(
                      leading: new IconButton(
                        color: Colors.lightBlue,
                        icon: Icon(Icons.star),
                        onPressed: () {},
                      ),
                      title: Text(
                        "pHValue: ${snap[index]['phval']}",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      subtitle: Text('Date:${snap[index]['date'].toString()}'),
                    )))),
                  );
                },
              );
            }),

        // child: Container(
        //   padding: EdgeInsets.all(8.0),
        //   decoration: BoxDecoration(
        //       border: Border(
        //         bottom: BorderSide(color: Colors.grey),
        //       ),
        //       color: Colors.grey[100]),
        //   child: TextField(
        //     decoration: InputDecoration(
        //         border: InputBorder.none,
        //         hintText: "Email or Phone number",
        //         hintStyle: TextStyle(color: Colors.grey[400])),
        //   ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          showAlertDialog(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PhReading()),
          );
          print("Fuck you !");
          print(getMethod());
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("PH of water"),
      content: Text("The water is acidic."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
