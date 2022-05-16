// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

class Ex1HomePage extends StatefulWidget {
  const Ex1HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex1HomePage> createState() => _Ex1HomePageState();
}

class _Ex1HomePageState extends State<Ex1HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 1',
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
      body: Center(
        child: Text(
          'Hello World',
          style: TextStyle(
            fontSize: 30,
            // fontWeight: FontWeight.bold,
          )
        ),
      ),
    );
  }
}

class Ex2HomePage extends StatefulWidget {
  const Ex2HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex2HomePage> createState() => _Ex2HomePageState();
}

class _Ex2HomePageState extends State<Ex2HomePage> {

  String name = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 2',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // create a textbox and when the text changes update the state
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Your Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Your Name is : " +name,
            style: TextStyle(
              fontSize: 17,
              // fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  }
}

class Ex3HomePage extends StatefulWidget {
  const Ex3HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex3HomePage> createState() => _Ex3HomePageState();
}

class _Ex3HomePageState extends State<Ex3HomePage> {

  Widget space(){
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
    );
  }

  Future<void> submitAction() async{
    setState(() {
      name = controller.text;
      password = passwordController.text;
    });
  }
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState(){
    super.initState();
    states.sort((a, b) => a.compareTo(b));
  }

  String name = '';
  String password = '';
  String age = '';
  String date = '';
  String? selectedState = 'Tamil Nadu';
  List<String> states = ['Tamil Nadu', 'Kerala', 'Andhra Pradesh', 'Karnataka', 'Goa', 'Telangana', 'Maharastra', 'Madhya Pradesh', 'Uttar Pradesh', 'West Bengal', 'Arunachal Pradesh','Assam', "Bihar", 'Chattisgarh', 'Gujarath', 'Haryana','Himachal Pradesh','Jharkhand', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odissha', 'Punjab', 'Rajasthan', 'Sikkhim', 'Tiripura', 'Uttarkhand'];


  Widget textInput(String hint, TextEditingController controller, String variable, bool isPassword, bool isNumeric, IconData icon){
    return Center(
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          style: TextStyle(
            fontSize: 17
          ),
          controller: controller,
          onChanged: (value){
            print(value);
            setState(() {
              variable = value;
            });
          },
          obscureText: isPassword ? true : false,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.name,
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget remindButton = TextButton(
    child: Text("Ok"),
    onPressed:  () => Navigator.pop(context),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text(
      'Name:\t\t'+name+'\nPassword:\t\t'+password+'\nAge:\t\t'+age+'\nDOB:\t\t'+date+'\nState:\t\t'+selectedState.toString(),
    ),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 3',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            space(),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: controller,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      name = value;
                    });
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: passwordController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: ageController,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      age = value;
                    });
                  },
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.tag_outlined),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () async{
                final dateTime = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1970), 
                  lastDate: DateTime.now(),
                );
                if(dateTime != null){
                  var month = dateTime.month == 1 ? 'Jan' : dateTime.month == 2? 'Feb' : dateTime.month == 3? 'Mar' : dateTime.month == 4? 'Apr' : dateTime.month == 5? 'May' : dateTime.month == 6? 'Jun' : dateTime.month == 7? 'Jul' : dateTime.month == 8? 'Aug' : dateTime.month == 9? 'Sep' : dateTime.month == 10? 'Oct' : dateTime.month == 11? 'Nov' : 'Dec';
                  dateController.text = dateTime.year.toString() + ' ' + month.toString() + ' ' + dateTime.day.toString();
                  date = dateController.text;
                }
              },
              child: Center(
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(
                      fontSize: 17
                    ),
                    controller: dateController,                
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(),
                      hintText: 'Date Of Birth',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: DropdownButtonFormField(
                items: states.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category)
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => selectedState = newValue.toString());
                  },
                  value: selectedState,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    filled: true,
                    fillColor: Colors.white38,
                )
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
                showAlertDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(1,2.5)
                    )
                  ],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}