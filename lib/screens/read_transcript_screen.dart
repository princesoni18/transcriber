import 'package:assignment/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadTranscriptScreen extends StatelessWidget {
  const ReadTranscriptScreen({super.key,required this.name,required this.text,required this.timestamp});
  final String text;
  final String name;
  final Timestamp timestamp;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(

      title: Text(name),

      surfaceTintColor: Colors.transparent,
      foregroundColor: primaryColor,
      elevation: 0.0,
    ),
      body: ListView(
         padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        shrinkWrap: true,

         children: [
           Text( DateFormat('d MMM yyyy').format(timestamp.toDate()),textAlign: TextAlign.right,style: const  TextStyle(color: primaryColor,fontSize: 20)),

           const SizedBox(height: 20,),
          Text(text,style: const  TextStyle(color: primaryColor,fontSize: 35),textAlign: TextAlign.left,),


         ],
      ),
    );
  }
}