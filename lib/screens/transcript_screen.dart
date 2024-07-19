import 'dart:io';

import 'package:assignment/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:path/path.dart' as p;

class TranscriptScreen extends StatefulWidget {
  const TranscriptScreen({super.key});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  SpeechToText _speechToText = SpeechToText();
  final AudioRecorder audioRecorder=AudioRecorder();
  final AudioPlayer audioPlayer=AudioPlayer();

 bool _speechEnabled = false;
  String _lastWords = '';
  String? recordingPath;
  String total="";
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
        
    _speechEnabled = await _speechToText.initialize(

      
      
      
    );
    setState(() {});
  }
  void _startListening() async {
    
          
     await _speechToText.listen(onResult: _onSpeechResult,
     pauseFor: const Duration(seconds: 30),
      listenOptions: SpeechListenOptions(
        cancelOnError: false
        
      )
     );
    
    setState(() {});
  }

   void _stopListening() async {
    await _speechToText.stop();
    total+=_lastWords;
    _lastWords="";
    
    setState(() {

    });
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(

      title: Text("Transcipt Maker"),
     ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
           const SizedBox(height: 20,),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5  ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                     width: double.maxFinite,
                     padding:const  EdgeInsets.all(10),
                            
                      decoration: BoxDecoration(color: inversePrimaryColor,
                      border: Border.all(color: secondaryColor,width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: secondaryColor,offset: Offset(2, 3),blurRadius: 2)]
                      
                      ),
                      child: Text(_lastWords.isNotEmpty||total.isNotEmpty
                      ? total+_lastWords
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : 
                       'Tap the microphone to start listening...'
                         ,style: const TextStyle(fontSize: 20),),
                            
                      
                    ),
                  ],
                ),
              ),
            ),


            // ElevatedButton(onPressed: (){

            //   if(audioPlayer.playing){

            //     audioPlayer.stop();
            //     setState(() {
                  
            //     });
            //   }
            //   else {

            //     audioPlayer.setFilePath(recordingPath!);
            //     audioPlayer.play();
            //   }
            // }, child: audioPlayer.playing?const Icon(Icons.stop):const Icon(Icons.play_arrow)),


          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,color: primaryColor,),
      ),
    );
  }
}


