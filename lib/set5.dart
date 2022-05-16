// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_local_variable
import 'dart:io';
import 'dart:ui';

import 'package:file_manager/controller/file_manager_controller.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Ex11HomePage extends StatefulWidget {
  const Ex11HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex11HomePage> createState() => _Ex11HomePageState();
}

class _Ex11HomePageState extends State<Ex11HomePage> {

  @override
  void initState(){
    super.initState();
    loadFile();
  }

  List<String> username = [];
  List<String> password = [];

  Future<void> loadFile() async{
    await rootBundle.loadString('assets/login.txt').then((value) {
      print("value: $value");
      var x = value.split(' ');
      print(x.length);
      print(x);
      print('\n');
      for (var i = 0; i < x.length; i++) {
        if(i %2 == 0){
          username.add(x[i]);
        }
        else{
          password.add(x[i]);
        }
      }
      print(username);
      print(password);
    });
  }

  String typedUsername = '';
  String typedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 11",style: TextStyle(color: Colors.black),),
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  typedUsername = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: (value){
                setState(() {
                  typedPassword = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              onPressed: (){
                var index = username.indexWhere((element) => element == typedUsername);
                if(password[index] == typedPassword){
                  print(password[index]);
                  print("Login Successful");
                }
                else{
                  print(password[index]);
                  print("Login Failed");
                }
              },
              child: Text("Login"),
            ),
          )
        ],
      ),
    );
  }
}

class Ex12HomePage extends StatefulWidget {
  const Ex12HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex12HomePage> createState() => _Ex12HomePageState();
}

class _Ex12HomePageState extends State<Ex12HomePage> {

  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 12",style: TextStyle(color: Colors.black),),
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
      body: FileManager(
        controller: controller,
        builder: (context, snapshot) {
          final List<FileSystemEntity> entities = snapshot;
            return ListView.builder(
              itemCount: entities.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: FileManager.isFile(entities[index])
                        ? Icon(Icons.feed_outlined)
                        : Icon(Icons.folder),
                    title: Text(FileManager.basename(entities[index])),
                    onTap: () {
                      if (FileManager.isDirectory(entities[index])) {
                          controller.openDirectory(entities[index]);   // open directory
                        } else {
                            // Perform file-related tasks.
                        }
                    },
                  ),
                );
              },
            );
        },
      ),
    );
  }
}

class Ex13HomePage extends StatefulWidget {
  const Ex13HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex13HomePage> createState() => _Ex13HomePageState();
}

class _Ex13HomePageState extends State<Ex13HomePage> {

  List<Contact> contacts = [];
  bool isLoaded = false;

  Future<void> fetchContacts() async{
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts = await FlutterContacts.getContacts();
      setState(() {
        isLoaded = true;
      });
      print(contacts);
      print('yup');

      // // Get all contacts (fully fetched)
      // contacts = await FlutterContacts.getContacts(
      //     withProperties: true, withPhoto: true);

      // // Get contact with specific ID (fully fetched)
      // Contact? contact = await FlutterContacts.getContact(contacts.first.id);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 13",style: TextStyle(color: Colors.black),),
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
      body: isLoaded ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.99,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isLoaded ? contacts.length : 0,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        contacts[index].displayName.toString()[0],
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    title: Text(contacts[index].displayName),
                  );
                },
              ),
            )
          ],
        ),
      ) : Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),),
    );
  }
}