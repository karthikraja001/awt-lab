// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Ex16HomePage extends StatefulWidget {
  const Ex16HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex16HomePage> createState() => _Ex16HomePageState();
}

class _Ex16HomePageState extends State<Ex16HomePage> {

  List<Color> colors = [Colors.green.shade300, Colors.blueGrey.shade300, Colors.teal.shade300, Colors.purple.shade300, Colors.green.shade300];
  CarouselController cpntrol = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 16",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          height: MediaQuery.of(context).size.height * 0.88),
        items: ["Welcome", "Introduction", "Explaination", "Conclusion", "End"].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade300
                ),
                child: Center(child: Text(i, style: TextStyle(fontSize: 16.0),))
              );
            },
          );
        }).toList(),
      ),
    );
  }
}