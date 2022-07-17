import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lasttimecrud/homescreen.dart';
import 'package:lasttimecrud/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = "";
  var password = "";
  var eCode = "";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  login() async {
     try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
         password: password);
         return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScrenn()));
    }on FirebaseAuthException catch (e) {
      setState(() {
        eCode = e.code;
      });
    }catch (e){
      print(e);
    }
  }
  cleartext(){
    emailcontroller.clear();
passwordcontroller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(height: 30,),
                Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text("$eCode",style: TextStyle(fontSize: 10,color: Colors.red,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      label: Text("Email")
                    ),
                    controller: emailcontroller,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email";
                      }else if(!value.contains('@')){
                        return "please enter valid email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      label: Text("Password")
                    ),
                    controller: passwordcontroller,
                     validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    }
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? Register"),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      }, icon: Icon(Icons.app_registration_rounded),color: Colors.blue,),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailcontroller.text; 
                      password = passwordcontroller.text; 
                      login();
                      cleartext();
                    });
                  }
                }, child: Text("Login",style: TextStyle(fontSize: 20),)
                ,style: ElevatedButton.styleFrom(
                  // shape: Radius.circular(),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  onSurface: Colors.purple
                ),
                
                )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}