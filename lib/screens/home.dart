import 'package:assignment/colors.dart';
import 'package:assignment/controllers/services/auth_service.dart';
import 'package:assignment/screens/login_page/login_page.dart';
import 'package:assignment/screens/read_transcript_screen.dart';
import 'package:assignment/screens/transcript_screen.dart';
import 'package:assignment/screens/trial.dart';
import 'package:assignment/screens/whisper_screen.dart';
import 'package:assignment/widgets/transcript_Tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    
    appBar: AppBar(
       foregroundColor: primaryColor,
       title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('T R A N S C R I B E R')),

      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      
      
    ),


    drawer: Drawer(



      child: ListView(

      
     shrinkWrap: true,
        children: [
          const SizedBox(height: 50,),

          ListTile(
            onTap: ()async{
         

      await   AuthService().logOutUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),));
            },
           tileColor: Colors.grey,
            title: Text("Log out ",style: TextStyle(color: primaryColor),),
            trailing: Icon(Icons.logout_rounded,color: primaryColor,),
          )
        ],
      ),
    ),

    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
      
          Text("Your Transcripts",style: TextStyle(fontSize: 20,color: primaryColor),),
          const SizedBox(height: 20,),
      
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('transcripts').doc(FirebaseAuth.instance.currentUser!.uid).collection('my transcripts').snapshots(),
            builder: (context, snapshot) {
              
              if(snapshot.connectionState==ConnectionState.active&&snapshot.hasData){
                

               if(snapshot.data!.docs.length==0){

                 return Center(child: Text("you do not have any transcriptions right now , create a new one by tapping on the add icon",style: TextStyle(color: primaryColor),),);
               }
                return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
            
            
                return GestureDetector(
                  
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ReadTranscriptScreen(name: snapshot.data!.docs[index]['name'], text: snapshot.data!.docs[index]['text'], timestamp: snapshot.data!.docs[index]['timestamp']),)),
                  child: TranscriptTile(name: snapshot.data!.docs[index]['name'],time:  DateFormat('d MMM yyyy').format(snapshot.data!.docs[index]['timestamp'].toDate())));
              
            },);

                

              }

              else if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: Text("laoding your data"),);
              }

              return const Center(child: Text("unable to fetch your data"),);

            
            },
          
          )
        ],
      ),
    ),
     floatingActionButton: FloatingActionButton(backgroundColor: inversePrimaryColor,


      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConverterScreen(),));
      },child: const Icon(Icons.add,color: primaryColor,),),
    );
  }
}