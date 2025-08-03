/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Showdata extends StatefulWidget {
  const Showdata({super.key});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
       builder: (context,snapshots){
        if(snapshots.connectionState==ConnectionState.active){
        if(snapshots.hasData){
        return ListView.builder(itemBuilder: (context,index){
          return ListTile(
          leading: CircleAvatar(
            child:Text("${index+1}"),
          ),
          title:Text("${snapshots.data!.docs[index]["title"]}"),
          subtitle: Text("${snapshots.data!.docs[index]["description"]}"),
          );
        });
        }
        else if(snapshots.hasError){
       return Center(child:Text ("${snapshots.hasError.toString()}"));
        }
        }
        else{
          return const Center(child:CircularProgressIndicator());
        }
       },
    ),);
  }
}*/