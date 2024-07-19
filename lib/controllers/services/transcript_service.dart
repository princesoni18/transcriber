import 'package:assignment/models/transcript_model.dart';
import 'package:assignment/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class TranscriptService{

final FirebaseFirestore _firestore=FirebaseFirestore.instance;


   Future<String> uploadTranscript(String name,String text)async{
   

   try{

    TranscriptModel transcript=TranscriptModel(name: name, timestamp: Timestamp.now(), text: text);
    String transcriptId=const Uuid().v1();
    await _firestore.collection('transcripts').doc(FirebaseAuth.instance.currentUser!.uid).collection('my transcripts').doc(transcriptId).set(transcript.toJson());

    return 'success';
   }

   catch(e){
    

    return "unable to save your transcript";
      
   } 

  }
}