import 'dart:io';

import 'package:assignment/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:whisper_flutter_plus/whisper_flutter_plus.dart';

class WhisperScreen extends StatefulWidget {
  const WhisperScreen({super.key});

  @override
  State<WhisperScreen> createState() => _WhisperScreenState();
}

class _WhisperScreenState extends State<WhisperScreen> {
  
  final AudioRecorder audioRecorder=AudioRecorder();
  final AudioPlayer audioPlayer=AudioPlayer();

 bool _speechEnabled = false;
  
  String? recordingPath;
  String? result;
  String total="";
  final Whisper whisper = const Whisper(
    model: WhisperModel.base,
);
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }
  sendToWhisper()async{
   
    try{
    final WhisperTranscribeResponse transcription = await whisper.transcribe(
    transcribeRequest: TranscribeRequest(
        audio: recordingPath!,
        isTranslate: true, // Translate result from audio lang to english text
        isNoTimestamps: false, // Get segments in result
        splitOnWord: true, // Split segments on each word 
    ),
    

);
print(transcription);
print(transcription.text);
setState(() {
       result =transcription.text;
    });
}
catch(e){
  print(e.toString());
}
   
    
  }
  void _initSpeech() async {
        
   
    setState(() {});
  }
  void _startListening() async {
    
          
     
    
    setState(() {});
  }

   void _stopListening() async {
  
    
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(



  body: Column(

    children: [


        result==null?Center(child: CircularProgressIndicator(),):Text(result!,style: TextStyle(color: primaryColor),),
       ElevatedButton(onPressed: (){

              if(audioPlayer.playing){

                audioPlayer.stop();
                setState(() {
                  
                });
              }
              else {

                audioPlayer.setFilePath(recordingPath!);
                audioPlayer.play();
              }
            }, child: audioPlayer.playing?const Icon(Icons.stop):const Icon(Icons.play_arrow)),
    ],
  ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed:
            // If not yet listening for speech start, otherwise stop
           ()async{

            if(_speechEnabled){
            String ? filePath=await audioRecorder.stop();
            setState(() {
              _speechEnabled=false;
              recordingPath=filePath;
            });

            sendToWhisper();
            }
            else {
              if(await audioRecorder.hasPermission()){
                final Directory appDocumnetDir=await getApplicationDocumentsDirectory();
                final String path=p.join(appDocumnetDir.path,"recording.wav");
                await audioRecorder.start(RecordConfig(),path: path);
                setState(() {
                  _speechEnabled=true;
                  recordingPath=null;
                });
              }
            }
           },
        tooltip: 'Listen',
        child: Icon(_speechEnabled? Icons.mic_off : Icons.mic,color: primaryColor,),
      ),
    );
  }
}