import 'package:assignment/colors.dart';
import 'package:flutter/material.dart';

class  TranscriptTile extends StatelessWidget {
  final String name;
  final String time;
  const TranscriptTile({super.key,required this.name,required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        
      
      tileColor: inversePrimaryColor,
      
      minTileHeight: 90,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
   splashColor: Colors.grey,

      leading: Container(
        padding: EdgeInsets.all(5),
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: secondaryColor
        ),
        child: const Icon(Icons.closed_caption_rounded, size: 30,color: primaryColor,)),

        title: Text(name),
        

        subtitle: Text(time,style: TextStyle(color: Colors.grey),),
        
      ),
    );
  }
}