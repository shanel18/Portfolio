import 'dart:async';

import 'package:flame_konek/models/account_setup_model.dart';
import 'package:flutter/material.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? department;
  String? course;
  String? bio;
  TextEditingController bioController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  


  final _department = ["CMA", "CITE","CEA","CELA"];
  String? selectedDepartment ="";
  final _course = ["BSIT", "BSA","BSHM", "BSCE"];
  String? selectedCourse = ""; 

  String? selectedtitle ="";

  _MyFormState(){
    selectedDepartment = _department[0];
     selectedCourse = _course[0];
  }

  String message = "Set up Profile";
  bool buttonVisibility = true;

  void submit() {
      final form = _formKey.currentState;
        
    if(form!.validate()){
        form.save();

       bio = bioController.text;
      
        setState(() {
          message = "welcome: $username";
          buttonVisibility = false;
        });

        Timer(const Duration(seconds: 2), (){
        Navigator.pop(context, AccountSetupArguments({"username" : username, "bio": bio, "department" : selectedDepartment, "course" : selectedCourse}));
        });
    }    
  }

  @override
  void initState() {
    // TODO: implement initState
    _MyFormState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        elevation: 0.0,
        title: const Text("Setup Profile"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            color: Color(0xff28282B),
                  ),
        ),
      ),
      body: ListView(
        
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                     message,
                      style: const TextStyle(fontSize: 25.0 ,fontFamily: "Righteous",),
                    ),
                  ),
                ),
                 const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        validator: (value) {
                          if(value!.trim().length < 7 || value.isEmpty){
                            return "Too short !"; 
                          }else if (value.trim().length > 12){
                            return "Too long !";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be atleast 7 characters",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: DropdownButtonFormField(
                      value: selectedDepartment,
                      items: _department.map(
                        (e)=> DropdownMenuItem(child: Text(e), value: e,)
                        

                    ).toList(), 
                    onChanged: (val){
                      setState(() {
                        selectedDepartment = val as String;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down_circle, color: Colors.black,),
                    dropdownColor: Color(0xffFFF5EE),
                    decoration: InputDecoration(
                      labelText: "Department",
                        border: OutlineInputBorder(),
                    )
                    
                    )
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: DropdownButtonFormField(
                      value: selectedCourse,
                      items: _course.map(
                        (e)=> DropdownMenuItem(child: Text(e), value: e,)
                        

                    ).toList(), 
                    onChanged: (val){
                      setState(() {
                        selectedCourse = val as String;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down_circle, color: Colors.black,),
                    dropdownColor: Color(0xffFFF5EE),
                    decoration: InputDecoration(
                      labelText: "Course",
                        border: OutlineInputBorder(),
                    )
                    
                    )
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(                      
                       controller: bioController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "bio",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "input your bio",
                        ),
                      ),
                    ),
                  ),
                ),
                
                Visibility(
                  visible: buttonVisibility ,
                  child: GestureDetector(  
                    onTap: submit,
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                           
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
