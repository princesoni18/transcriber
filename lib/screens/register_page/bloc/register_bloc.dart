import 'dart:async';
import 'dart:typed_data';

import 'package:assignment/controllers/services/auth_service.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {

    on<SelectImageEvent>(selectImageEvent);
    on<CreateUser>(createUser);
    
  }

  FutureOr<void> selectImageEvent(SelectImageEvent event, Emitter<RegisterState> emit) async{
  
    {
  
  

  
  return ;
  }

    
  }



  FutureOr<void> createUser(CreateUser event, Emitter<RegisterState> emit)async {

    
   
    String response="";

    try{
       response=await AuthService().CreateUser(event.email, event.name, event.password);
       print(response);
       
    
    }
    catch(e){

      response=e.toString();
    }
   if(response!="success"){
    emit(ShowInfo(content: response));
   }  
   else{
    emit(RegisterSuccessState());
   }
  }
}
