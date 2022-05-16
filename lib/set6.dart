// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Ex14HomePage extends StatefulWidget {
  const Ex14HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex14HomePage> createState() => _Ex14HomePageState();
}

class _Ex14HomePageState extends State<Ex14HomePage> {

  Future<void> getDBDetails(String username, String password, BuildContext context) async{
    await DBHelper.getUsers(username).then((value) {
      if(value[0]!.password == password){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User logged in Successfully')
          )
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid login details')
          )
        );
      }
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 14",style: TextStyle(color: Colors.black),),
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
          Center(
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 17
                ),
                controller: usernameController,
                onChanged: (value){
                  print(value);
                  setState(() {
                    username = value;
                  });
                },
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Username',
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
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () async{
              getDBDetails(username, password, context);
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
        ],
      ),
    );
  }
}

class Ex15HomePage extends StatefulWidget {
  const Ex15HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex15HomePage> createState() => _Ex15HomePageState();
}

class _Ex15HomePageState extends State<Ex15HomePage> {

  Future<void> setUserDetails(String username, String password) async{
    await DBHelper.addUsers(UserDetails(userName: username, password: password)).then((value) => print('Success'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 15",style: TextStyle(color: Colors.black),),
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
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Ex15AddUsers()));
        }),
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: FutureBuilder<List<UserDetails?>>(
        future: DBHelper.getAllUsers(),
        builder: (context, AsyncSnapshot<List<UserDetails?>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(),),
            );
          }
          else if(snapshot.hasError){
            print(snapshot.hasData);
            print(snapshot.error);
            return Center(
              child: Text('No Users Found. Add new Users',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18
              )
              ),
            );
          }
          else if(snapshot.hasData){
            if(snapshot.data != null){
              var data = snapshot.data!;
              print('Yup');
              print(data);
              if(data.length != 0){
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      if(data.length == 0){
                        return Center(
                          child: Text('No Users found. Add new users to show them here',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          )
                          ),
                        );
                      }
                      return ListTile(
                        leading: Icon(
                          Icons.edit, color: Colors.black, size: 18,
                        ),
                        title: Text(data[index]!.userName!),
                        subtitle: Text(data[index]!.password!),
                      );
                    })
                  ),
                );
              }
              else{
                return Center(
                  child: Text('No users available. Add new users.')
                );
              }
            }
          }
          return Center(
            child: Text('No Users available. Add new Users to show users.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18
            )
            ),
          );
        },
      ),
    );
  }
}

class Ex15AddUsers extends StatefulWidget {
  const Ex15AddUsers({ Key? key }) : super(key: key);

  @override
  State<Ex15AddUsers> createState() => _Ex15AddUsersState();
}

class _Ex15AddUsersState extends State<Ex15AddUsers> {
  
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = '';
  String password = '';

  Future<void> addUsers(String username, String password, BuildContext context) async{
    await DBHelper.addUsers(UserDetails(userName: username, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add User",style: TextStyle(color: Colors.black),),
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
          Center(
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 17
                ),
                controller: usernameController,
                onChanged: (value){
                  print(value);
                  setState(() {
                    username = value;
                  });
                },
                obscureText: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Username',
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
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () async{
              addUsers(username, password, context).then((value){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added User Successfully')
                  )
                );
                Navigator.pop(context);
              });
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
        ],
      ),
    );
  }
}

class UserDetails {
  final String? userName;
  final String? password;

  const UserDetails({required this.userName, required this.password});

  factory UserDetails.fromJSON(Map<String, dynamic> json) => UserDetails(userName: json['username'], password: json['password']);
  Map<String, dynamic> toJSON() => {
    'username': userName,
    'password': password
  };
}

class DBHelper{
  static const int version = 1;
  static const String dbName = "Userdetails.db";
  
  static Future<Database> _getDB() async{
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: ((db, version) async {
        await db.execute('CREATE TABLE USERDETAILS(username VARCHAR NOT NULL, password VARCHAR NOT NULL);');
      }),
      version: version
    );
  }

  static Future<int> addUsers(UserDetails userDetails) async{
    final db = await _getDB();
    return await db.insert("USERDETAILS", userDetails.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(UserDetails userDetails) async{
    final db = await _getDB();
    return await db.update('USERDETAILS', userDetails.toJSON(), where: 'id = ?', whereArgs: [userDetails.userName], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(UserDetails userDetails) async{
    final db = await _getDB();
    return await db.delete('USERDETAILS', where: 'id = ?', whereArgs: [userDetails.userName]);
  }

  static Future<List<UserDetails?>> getAllUsers() async{
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("USERDETAILS");
    if(maps.isEmpty){
      return [];
    }
    else{
      // var x = List.generate(maps.length, (index) => UserDetails.fromJSON(maps[index]));
      var x= '';
      print(maps);
      print("X="+x.toString());
    }
    return List.generate(maps.length, (index) => UserDetails.fromJSON(maps[index]));
  }

  static Future<List<UserDetails?>> getUsers(String userName) async{
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("USERDETAILS", where: 'username = ?', whereArgs: [userName]);
    if(maps.isEmpty){
      return [];
    }
    else{
      return List.generate(maps.length, (index) => UserDetails.fromJSON(maps[index]));
    }
  }


}