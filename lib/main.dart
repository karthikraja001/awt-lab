// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:mobilelab/set1.dart';
import 'package:mobilelab/set2.dart';
import 'package:mobilelab/set3.dart';
import 'package:mobilelab/set4.dart';
import 'package:mobilelab/set5.dart';
import 'package:mobilelab/set6.dart';
import 'package:mobilelab/set7.dart';
import 'package:mobilelab/set8.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadExercise(),
    );
  }
}

class LoadExercise extends StatefulWidget {
  const LoadExercise({ Key? key }) : super(key: key);

  @override
  State<LoadExercise> createState() => _LoadExerciseState();
}

class _LoadExerciseState extends State<LoadExercise> {
  List<dynamic> pages = [
    Ex1HomePage(),
    Ex2HomePage(),
    Ex3HomePage(),
    Ex4HomePage(),
    Ex5HomePage(),
    Ex6HomePage(),
    Ex7HomePage(),
    Ex8HomePage(),
    Ex9HomePage(),
    Ex10HomePage(),
    Ex11HomePage(),
    Ex12HomePage(),
    Ex13HomePage(),
    Ex14HomePage(),
    Ex15HomePage(),
    Ex16HomePage(),
    Ex17HomePage(),
    Ex18HomePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Mobile Lab Exercises',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black
          ),
        ),
      ),
      backgroundColor: Colors.white,
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     GestureDetector(
      //       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Ex1HomePage())),
      //       child: Center(
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             border: Border.all(color: Colors.black87),
      //             borderRadius: BorderRadius.circular(3),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.orange.withOpacity(0.1),
      //                 blurRadius: 5,
      //                 spreadRadius: 5,
      //               ),
      //             ],
      //           ),
      //           child: Text('Exercise 1'),
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 25),
      //    ]
      // ),

      body : ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Exercise ${index + 1}'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index])),
          );
        },
      ),

    );
  }
}

