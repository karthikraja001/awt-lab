// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Ex4HomePage extends StatefulWidget {
  const Ex4HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex4HomePage> createState() => Ex4HomePageState();
}

class Ex4HomePageState extends State<Ex4HomePage> {

  String foneNum = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 4',
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      hintText: "Enter Mobile Number",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        foneNum = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  try {
                    print(foneNum.substring(0, 3));
                    print(foneNum.length);
                    if(foneNum.substring(0, 3) == "+91") {
                      if(foneNum.length == 13) {
                        // show snackbar with success message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Valid Mobile Number"),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid Mobile Number"),
                          backgroundColor: Colors.red.shade300,
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid Mobile Number"),
                        backgroundColor: Colors.red.shade300,
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid Mobile Number"),
                      backgroundColor: Colors.red.shade300,
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ex5HomePage extends StatefulWidget {
  const Ex5HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex5HomePage> createState() => _Ex5HomePageState();
}

class _Ex5HomePageState extends State<Ex5HomePage> {

  List<String> users = ['John','Alice','Bob','Charles'];
  List<String> profilePic = ['https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png','https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png','https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png','https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'];
  List<String> status = ['Online','Offline','Online','Online','Online','Online'];
  List<String> emails = ['john@example.com','alice@example.com','bob@example.com','charles@exaple.com'];
  List<String> gender = ['Male','Female','Male','Male'];

  @override
  void initState(){
    super.initState();
    setState(() {
      selectedUser = users[0];
      selectedPics = profilePic[0];
      selectedStatus = status[0];
      selectedEmail = emails[0];
      selectedGender = gender[0];
      selectedIndex = 0;
    });
  }

  String selectedUser = '';
  String selectedPics = '';
  String selectedStatus = '';
  String selectedEmail = '';
  String selectedGender = '';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 5',
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
      body: MediaQuery.of(context).orientation == Orientation.portrait ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // create a list of users with their names and images
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ex5Details(
                          name: users[index],
                          profilePic: profilePic[index],
                          status: status[index],
                          email: emails[index], 
                          gender: gender[index],
                        )
                      )
                    );
                  },
                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profilePic[index]),
                    ),
                    title: Text(users[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ) : Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.orange
            ),
            child: Container(
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedUser = users[index];
                        selectedPics = profilePic[index];
                        selectedStatus = status[index];
                        selectedEmail = emails[index];
                        selectedGender = gender[index];
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      color: selectedIndex == index ? Colors.grey.shade200 : Colors.transparent,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profilePic[index]),
                        ),
                        title: Text(users[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // display the data passed to this screen
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(selectedPics),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      selectedUser,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      selectedEmail,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      selectedStatus,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      selectedGender,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Ex5Details extends StatefulWidget {
  final String name;
  final String profilePic;
  final String status;
  final String email;
  final String gender;
  const Ex5Details({ Key? key, required this.name, required this.profilePic, required this.status, required this.email, required this.gender }) : super(key: key);

  @override
  State<Ex5Details> createState() => _Ex5DetailsState();
}

class _Ex5DetailsState extends State<Ex5Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          widget.name,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // display the data passed to this screen
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(widget.profilePic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.status,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.gender,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

class Ex6HomePage extends StatefulWidget {
  const Ex6HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex6HomePage> createState() => _Ex6HomePageState();
}

class _Ex6HomePageState extends State<Ex6HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Exercise 6',
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
          Center(
            child: GestureDetector(
              onTap: () async{
                await launch('https://www.google.com');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Text(
                    'Open Browser',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () async{
                await launch('tel:+919012345678');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Text(
                    'Open Dialler',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () async{
                await launch('sms:+919012345678;?&body=Hello');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Text(
                    'Open Message',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
