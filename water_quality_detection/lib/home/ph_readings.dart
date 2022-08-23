import 'package:flutter/material.dart';
// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:water_quality_detection/Animation/FadeAnimation.dart';

class PhReading extends StatefulWidget {
  const PhReading({Key? key}) : super(key: key);

  @override
  State<PhReading> createState() => _PhReadingState();
}

class _PhReadingState extends State<PhReading> {
  getReadings() async {
    String theUrl =
        "https://unfamiliar-hunts.000webhostapp.com/sensor-data.php";
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
      body: FutureBuilder(
          future: getReadings(),
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
                  8,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          print("Fuck you !");
          print(getReadings());
        },
      ),
    );
  }
}
