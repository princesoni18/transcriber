import 'package:assignment/colors.dart';
import 'package:assignment/controllers/services/transcript_service.dart';
import 'package:assignment/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text_ultra/speech_to_text_ultra.dart';


class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool mIsListening = false;
  String mEntireResponse = '';
  String mLiveResponse = '';

String title="transcript name";

  final  TextEditingController _nameController=TextEditingController();
   ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

    _nameController.text="transcript name";
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _scrollController.dispose();
  }

  void scrollToBottom(){
    
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.fastEaseInToSlowEaseOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          foregroundColor: primaryColor,
       
         
        title:  Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        surfaceTintColor: Colors.transparent,

        actions: [

          GestureDetector(
            onTap:()=> _showInputDialog(context,_nameController),
            child: Icon(Icons.edit)),
            const SizedBox(width: 20,),
          Container(
            width: 90,
            child: ElevatedButton(
              onPressed: ()async{
            
               String result =await  TranscriptService().uploadTranscript(_nameController.text,mEntireResponse);
            
               if(result=='success'){
                showSnackbar("saved successfully" , context);
                Navigator.pop(context);
               }
               else {
            
            
                showSnackbar(result, context);
               }
              }, child: const Text("save"),style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
          ),
            const SizedBox(width: 10,)
            ],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: 
           ListView(

            shrinkWrap: true,
            
              children:[ 
                 Container(
          
                  height: MediaQuery.of(context).size.height-180,
                
                  child: 
                SingleChildScrollView(
                  controller: _scrollController,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mIsListening
                          ? Text('$mEntireResponse $mLiveResponse',style: const TextStyle(color: primaryColor,fontSize: 35),)
                          : Text(mEntireResponse,style: const TextStyle(color: primaryColor,fontSize: 35),),
                      const SizedBox(height: 20),
                      
                    ],
                  ),
                ),
              ),
          
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  
                  backgroundColor: Colors.grey,
                  radius: 40,
                  child: SpeechToTextUltra(
                          
                          ultraCallback:
                              (String liveText, String finalText, bool isListening) {
                  
                            setState(() {

                              WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
                              mLiveResponse = liveText;
                              mEntireResponse = finalText;
                              mIsListening = isListening;
                            });
                          },
                          toPauseIcon: const Icon(Icons.pause,),
                          toStartIcon: const Icon(Icons.mic),
                          pauseIconColor: Colors.white,
                          startIconColor: Colors.white,
                        ),
                ),
              ),
                    const SizedBox(
                      height: 10,
                    ),
              ]
            ),
        ),
      
      
    );
  }


void _showInputDialog(BuildContext context,TextEditingController _nameController) {
  
    
    showDialog(
      
      context: context,
      builder: (context) {
        return AlertDialog(
          
          backgroundColor: const Color.fromARGB(255, 35, 35, 35),
          title: const Text('Name  your File',style: TextStyle(color: primaryColor),),
          content: TextField(

            style: const TextStyle(color: primaryColor),
            controller: _nameController,
            decoration: const InputDecoration(hintText: ""),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Discard'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the save action
                    title= _nameController.text;
                    setState(() {
                      
                    });
                    
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}