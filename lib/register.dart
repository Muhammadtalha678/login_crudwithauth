
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lasttimecrud/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController  EmailController = TextEditingController();
TextEditingController passController = TextEditingController();
var email = "";
  var password = "";
       var eCode = "";
signup() async{
  try {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    setState(() {
      eCode = "The password provided is too weak.";
    });
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    setState(() {
      eCode = "The account already exists for that email.";
    });
  }
} catch (e) {
  print(e);
}
}
cleartext(){
    EmailController.clear();
passController.clear();
  }
  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
      return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      label: Text("Email")
                    ),
                    controller: EmailController,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email";
                      }else if(!value.contains('@')){
                        return "please enter valid email";
                      }else if(eCode == "The account already exists for that email."){
                        return eCode;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      label: Text("Password")
                    ),
                    controller: passController,
                     validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      }else if(eCode == "The password provided is too weak."){
                        return eCode;
                      }
                      return null;
                    }
                  ),
                ),
                 SizedBox(height:10,),
                
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? Login"),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      }, icon: Icon(Icons.login),color: Colors.blue,),
                    ],
                  ),
                ),
                SizedBox(height:10,),
                ElevatedButton(onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = EmailController.text; 
                      password = passController.text; 
                      signup();
                      cleartext();
                    });
                  }
                }, child: Text("Register",style: TextStyle(fontSize: 20),)
                ,style: ElevatedButton.styleFrom(
                  // shape: Radius.circular(),
                  padding: EdgeInsets.symmetric(horizontal:30),
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