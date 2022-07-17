import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScrenn extends StatefulWidget {
  const HomeScrenn({Key? key}) : super(key: key);

  @override
  State<HomeScrenn> createState() => _HomeScrennState();
}

class _HomeScrennState extends State<HomeScrenn> {
  CollectionReference data = FirebaseFirestore.instance.collection('flutter_class').doc('sec A').collection('Students');
  inserted(){
    Map<String,dynamic> ourdata={
      "name" :"Talha",
      "email" :"Talha@gmail.com",
    };
    data.add(ourdata).then((value) => print("Inserted Success"));
  }
  Show()async{
  StreamBuilder(
      stream: datastream,
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasError){print("Something went wrong");}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          print(snapshot.hasData);
          return Container();
    });
    //  var dat = getdata.get().then((value) => print("show Success"));
    // print(dat);
  }
  
  @override
  final Stream<QuerySnapshot> datastream = FirebaseFirestore.instance.collection('flutter_class').doc('sec A').collection('Students').snapshots();
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: datastream,
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasError){print("Something went wrong");}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          List list = [];
          
            
          snapshot.data!.docs.map((DocumentSnapshot document) => {
            list.add(document.data),
           
          }).toList();
            print(list);
          return Container();
        
       
    }); 
    
    
  }
}