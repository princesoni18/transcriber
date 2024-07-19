import 'package:assignment/colors.dart';
import 'package:assignment/firebase_options.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/login_page/login_page.dart';
import 'package:assignment/screens/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prince Soni assignment',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme:const ColorScheme.light(
          primary: Colors.white,

          surface: bgColor
        )
      ),
      home:  StreamBuilder(

        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot) {
          
         if(snapshot.connectionState==ConnectionState.active){
        if(snapshot.hasData){
          return Home();
        }
        else if(snapshot.hasError){
          return const Center(child:  Text("Some Error Occured"),);
    
        }
        
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:  CircularProgressIndicator(color: Colors.brown,),);
        }
        return Register_Page();
        },
        ),
    );
  }
}

