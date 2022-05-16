// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Ex7HomePage extends StatefulWidget {
  const Ex7HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex7HomePage> createState() => _Ex7HomePageState();
}

class _Ex7HomePageState extends State<Ex7HomePage> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText){
    if(buttonText == "CLEAR"){
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X"){
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";

    } else if(buttonText == "."){
      if(_output.contains(".")){
        print("Already conatains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "="){
      num2 = double.parse(output);
      if(operand == "+"){
        _output = (num1 + num2).toString();
      }
      if(operand == "-"){
        _output = (num1 - num2).toString();
      }
      if(operand == "X"){
        _output = (num1 * num2).toString();
      }
      if(operand == "/"){
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";

    } else {
      _output = _output + buttonText;
    }
    print(_output);
    setState(() {
      
      output = double.parse(_output).toStringAsFixed(2);

    });

  }
  
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(24.0),
        child: Text(buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
          ),
        onPressed: () => 
          buttonPressed(buttonText)
        ,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            'Exercise 7',
            style: TextStyle(
              fontSize: 19,
              color: Colors.black
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0
              ),
              child: Text(output, style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                
              ))),
            Expanded(
              child: Divider(),
            ),
            

            Column(children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),

              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("X")
              ]),

              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),

              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")
              ]),

              Row(children: [
                buildButton("CLEAR"),
                buildButton("="),
              ])
            ])
          ],
        )));
  }
}

class Ex8HomePage extends StatefulWidget {
  const Ex8HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex8HomePage> createState() => _Ex8HomePageState();
}

class _Ex8HomePageState extends State<Ex8HomePage> {

  List<String> qns = [
    "1. What is the capital of India?",
    "2. What is the capital of USA?",
    "3. What is the capital of UK?",
    "4. What is the capital of Canada?",
    "5. What is the capital of Australia?",
    "6. What is the capital of Germany?",
    "7. What is the capital of Italy?",
    "8. What is the capital of Japan?",
    "9. What is the capital of China?",
    "10. What is the capital of Russia?",
  ];

  List<String> ans = [
    "New Delhi",
    "Washington DC",
    "London",
    "Ottawa",
    "Canberra",
    "Berlin",
    "Rome",
    "Tokyo",
    "Beijing",
    "Moscow",
  ];

  List<List<String>> options = [
    ["New Delhi", "Washington DC", "London", "Ottawa"],
    ["Washington DC", "New Delhi", "London", "Ottawa"],
    ["London", "New Delhi", "Washington DC", "Ottawa"],
    ["Ottawa", "New Delhi", "Washington DC", "London"],
    ["Canberra", "New Delhi", "Washington DC", "Ottawa"],
    ["Berlin", "New Delhi", "Washington DC", "Ottawa"],
    ["Rome", "New Delhi", "Washington DC", "Ottawa"],
    ["Tokyo", "New Delhi", "Washington DC", "Ottawa"],
    ["Beijing", "New Delhi", "Washington DC", "Ottawa"],
    ["Moscow", "New Delhi", "Washington DC", "Ottawa"],
  ];

  int qnIndex = 0;
  int correct = 0;
  int incorrect = 0;
  int notAttempted = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = options[qnIndex][0] == ans[qnIndex];
    setState(() {
      if(userPickedAnswer == correctAnswer) {
        correct++;
      } else {
        incorrect++;
      }
      qnIndex++;
    });
  }

  bool isFinished() {
    return qnIndex == qns.length;
  }

  void resetQuiz() {
    setState(() {
      qnIndex = 0;
      correct = 0;
      incorrect = 0;
      notAttempted = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 8"),
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
      body: qnIndex != 10 ? Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Text(
                qns[qnIndex],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.green,
                        child: GestureDetector(
                          child: Text(
                            options[qnIndex][0],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => checkAnswer(true),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Text(
                            options[qnIndex][1],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => checkAnswer(false),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        color: Colors.green,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                          child: Text(
                            options[qnIndex][2],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => checkAnswer(true),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                          child: Text(
                            options[qnIndex][3],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => checkAnswer(false),
                        ),
                      ),
                    ] 
                  ) 
                ]
              )
            )
          )
        ]
      ) : Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // display the picture from internet
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    correct >=6 ?
                    'https://img.freepik.com/free-vector/men-success-laptop-relieve-work-from-home-computer-great_10045-646.jpg?t=st=1648288418~exp=1648289018~hmac=c3557f92c3942c6e79a619219149d0a4f2dd68a5a7e9cfdb3957d783e1387792&w=740'
                    :
                    'https://img.freepik.com/free-vector/businessman-catching-star-climbing-ladder-sky_74855-19696.jpg?t=st=1648290754~exp=1648291354~hmac=05e83a928ccc7ab46aac053b2d8dfc8b9e65aa9fec4faa158a708c5258dc7fdc&w=996'
                  )
                )
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "You have finished the quiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Your score is ${correct} out of ${qns.length}.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}