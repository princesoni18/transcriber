

import 'package:assignment/colors.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/login_page/bloc/login_bloc.dart';
import 'package:assignment/screens/login_page/bottom_text.dart';
import 'package:assignment/utils/snackbar.dart';
import 'package:assignment/widgets/MyTextField.dart';
import 'package:assignment/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Login_Page extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Login_Page({super.key});
  final LoginBloc loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc:loginBloc,
      listenWhen: (previous, current) => loginBloc.state is LoginActionState?true:false,
      listener: (context, state) {
        // TODO: implement listener
        if(state is LoginErrorState){
          showSnackbar(state.content, context);
        }
        if(state is LoginSuccessState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        }
       
      },
      child: Scaffold(
        
        //appbar

        appBar: AppBar(
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('T R A N S C R I B E R')),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),

        body: SingleChildScrollView(
            child: Column(
          children: [
           
            const SizedBox(
              height: 150,
            ),
            //email
           


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(
                hinttext: "Email",
                controller: _emailController,
                icon: Icon(Icons.email),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //password

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(
                  hinttext: "password", controller: _passwordController),
            ),
            const SizedBox(
              height: 20,
            ),
            //login button

            BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                if (state is LoginInitial) {
                  return MyButton(
                    text: "Login",
                    ontap: () {
                      loginBloc.add(LoginUserEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                  );
                } else {
                  return MyButton(
                    text: "Loging you in...",
                    ontap: () {},
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Bottom_Text(
              context: context,
            )
          ],
        )),
      ),
    );
  }
}
