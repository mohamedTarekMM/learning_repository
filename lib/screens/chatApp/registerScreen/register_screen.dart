import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/shared/shared_pref.dart';

import '../../../layout/chatApp/chat_app.dart';
import '../../../shared/components.dart';
import '../../../shared/constants.dart';
import 'cubit/chat_Register_state.dart';
import 'cubit/register_cubit.dart';

class ChatRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        defaultKeyboardDismissed(context: context);
      },
      child: Scaffold(
        backgroundColor: MPRIMARYCOLORS,
        appBar: AppBar(
          backgroundColor: MPRIMARYCOLORS,
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context)=>ChatRegisterCubit(),
          child: BlocConsumer<ChatRegisterCubit,ChatRegisterState>(
            listener: (context,state){
              if(state is RegisterUserSuccessfullyState){
                SharedPref.saveShopData(key: 'uId', value: state.uId).then((value) {
                  defaultNavigateAndKill(context, ChatAppLayoutScreen());
                  defaultToastMessage(message: 'Registration SuccessFully', state: ToastState.SUCCESS);
                });
              }
              if(state is RegisterUserErrorState){
                defaultToastMessage(message: state.error, state: ToastState.ERROR);
              }
            },
            builder: (context,state){
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/scholar.png',
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            'Scholar Chat',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Registration',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: defaultTextForm(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    label: 'Name',
                                    labelColor: Colors.white,
                                    prefixIconColor: Colors.white,
                                    outlineInputBorder: const OutlineInputBorder(),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Name is empty!';
                                      }
                                    },
                                    prefixIcon: Icons.person,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: defaultTextForm(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    label: 'Phone',
                                    labelColor: Colors.white,
                                    prefixIconColor: Colors.white,
                                    outlineInputBorder: const OutlineInputBorder(),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Phone is empty!';
                                      }
                                    },
                                    prefixIcon: Icons.phone,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: defaultTextForm(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    label: 'Email Address',
                                    labelColor: Colors.white,
                                    prefixIconColor: Colors.white,
                                    outlineInputBorder: const OutlineInputBorder(),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'email address is empty!';
                                      }
                                    },
                                    prefixIcon: Icons.email_outlined,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: defaultTextForm(
                                      controller: passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      label: 'Password',
                                      labelColor: Colors.white,
                                      prefixIconColor: Colors.white,
                                      suffixIconColor: Colors.white,
                                      outlineInputBorder: const OutlineInputBorder(),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'password is empty!';
                                        }
                                      },
                                      prefixIcon: Icons.lock,
                                      obscureText: ChatRegisterCubit.get(context).isPassword,
                                      suffixIcon:ChatRegisterCubit.get(context).isPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                                      suffixPressed: (){
                                        ChatRegisterCubit.get(context).getVisible();
                                      }
                                  ),
                                ),
                                ConditionalBuilder(
                                  condition: state is! RegisterUserLoadingState,
                                  builder:(context)=>Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: defaultMaterialTextButton(onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        ChatRegisterCubit.get(context).getRegisterUser(email: emailController.text.trim(), password: passwordController.text.trim(), name: nameController.text.trim(), phone: phoneController.text.trim());
                                        defaultKeyboardDismissed(context: context);
                                      }
                                    }, label: 'Register',isUpperCase: true,background: Colors.white,radius: 10,textColor: Colors.indigo),
                                  ),
                                  fallback: (context)=>const Center(child:  CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
