import 'package:cloud_firestore/cloud_firestore.dart';

class TranscriptModel {


  final String name;
  final Timestamp timestamp;
  final String text;

  TranscriptModel({required this.name, required this.timestamp, required this.text});

  factory TranscriptModel.fronJson(Map<String,dynamic> json){


    return TranscriptModel(name: json['name'], timestamp: json['timestamp'], text: json['text']);
  }

   Map<String,dynamic> toJson(){

    return {
      'name':name,
      'timestamp':timestamp,
      'text':text
    };
  }
}