


import 'package:assignment/colors.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/login_page/login_page.dart';
import 'package:assignment/screens/register_page/bloc/register_bloc.dart';
import 'package:assignment/utils/snackbar.dart';
import 'package:assignment/widgets/MyTextField.dart';
import 'package:assignment/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class Register_Page extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  Register_Page({super.key});
  RegisterBloc bloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: bloc,
      listenWhen: (previous, current)=> bloc.state is RegisterActionState,
      
    
      listener: (context, state) {
        // TODO: implement listener
        if(state is ShowInfo){
          var Currentstate=state;
          showSnackbar(Currentstate.content, context);
        }
        else if(state is RegisterSuccessState){
       
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        }
      },
      child: Scaffold(
       
        appBar: AppBar(
          title: const FittedBox(
            fit:BoxFit.scaleDown,child: Text('T R A N S C R I B E R')),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            
            const SizedBox(
              height: 20,
            ), 

       const Text("This is a demo signup , You can create account with any email and password",textAlign: TextAlign.center,style: TextStyle(color: primaryColor),),
        const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(
                hinttext: "Name",
                controller: _nameController,
                icon: Icon(Icons.person_2_rounded),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //email

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(
                hinttext: "Email",
                controller: _emailController,
                icon: const Icon(Icons.email_rounded),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //password

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(
                hinttext: "password",
                controller: _passwordController,
                icon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            
            //login button

            MyButton(
              text: "Sign In",
              ontap: () {
                
                 
               bloc.add(CreateUser(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                   ));
                  
              },
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:14.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(width: MediaQuery.of(context).size.width*0.18,),
                   Text("already a member ?",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),)),
                    child:  Text("Log in",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                )],
              ),
            )
          ],
        )),
      ),
    );
  }
}

class Initial_Profile extends StatelessWidget {
  const Initial_Profile({
    super.key,
    required this.bloc,
  });

  final RegisterBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
        radius: 50,
      ),
      Positioned(
          left: 55,
          top: 65,
          child: IconButton(
              onPressed: () => bloc.add(SelectImageEvent()),
              icon:const  Icon(Icons.add_a_photo_rounded)))
    ]);
  }
}
