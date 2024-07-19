import 'dart:typed_data';


import 'package:assignment/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

 final  FirebaseAuth _auth= FirebaseAuth.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<String> LogInUser(String email,String password)async{
String result="fill all fields";
  try{
  if(email.isNotEmpty&&password.isNotEmpty){
    UserCredential response= await _auth.signInWithEmailAndPassword(email: email, password: password);
    result="success";
  }
  else{
    result="enter all fields";
  }
   
   return result;
  }
  
  catch(e){

    return e.toString();
  }


}

Future<String> CreateUser(String email,String name,String password,)async{
String result="nottt";

  try{

    
   if(email.isNotEmpty&&password.isNotEmpty&&name.isNotEmpty){
    UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
     
    UserModel user=UserModel(name: name, email: email, uid: cred.user!.uid);
     await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

     result="success";
   }
   else{
    result="enter all fields";
   }
     return result;

  }
  catch(e){

    return e.toString();
  }

}
Future<void> logOutUser()async{

  try{
  await _auth.signOut();

  }catch(e){

    print(e.toString());
  }


}
}