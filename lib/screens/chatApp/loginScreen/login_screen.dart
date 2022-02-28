import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/screens/chatApp/loginScreen/cubit/chat_login_state.dart';
import 'package:wether_app/screens/chatApp/loginScreen/cubit/login_cubit.dart';
import 'package:wether_app/screens/chatApp/registerScreen/register_screen.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_state.dart';
import 'package:wether_app/shared/components.dart';
import 'package:wether_app/shared/constants.dart';
import 'package:wether_app/shared/shared_pref.dart';

import '../../../layout/chatApp/chat_app.dart';

class ChatLoginScreen extends StatelessWidget {
  ChatLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        defaultKeyboardDismissed(context:context);
      },
      child: Scaffold(
        backgroundColor: MPRIMARYCOLORS,
        appBar: AppBar(
          backgroundColor: MPRIMARYCOLORS,
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context)=>ChatLoginCubit(),
          child: BlocConsumer<ChatLoginCubit,ChatLoginState>(
            listener: (context,state){
              if(state is LoginUserSuccessState){
                SharedPref.saveShopData(key: 'uId', value: state.uId).then((value) {
                  defaultNavigateAndKill(context, ChatAppLayoutScreen());
                  defaultToastMessage(message: 'Login SuccessFully', state: ToastState.SUCCESS);
                });
              }
              if(state is LoginUserErrorState){
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.bold,color: Colors.white),
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
                                    outlineInputBorder: OutlineInputBorder(),
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
                                      outlineInputBorder: OutlineInputBorder(),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'password is empty!';
                                      }
                                    },
                                    prefixIcon: Icons.lock,
                                    obscureText: ChatLoginCubit.get(context).isPassword,
                                    suffixIcon:ChatLoginCubit.get(context).isPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                                    suffixPressed: (){
                                      ChatLoginCubit.get(context).getVisible();
                                    }
                                  ),
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginUserLoadingState,
                                  builder: (context)=>Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: defaultMaterialTextButton(onPressed: (){
                                      if(formKey.currentState!.validate()){
                                       ChatLoginCubit.get(context).getLoginUser(email: emailController.text.trim(), password: passwordController.text.trim());
                                       defaultKeyboardDismissed(context: context);
                                      }
                                    }, label: 'Login',isUpperCase: true,background: Colors.white,radius: 10,textColor: Colors.indigo),
                                  ),
                                  fallback: (context)=>const Center(child: CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Text("You don't have Account?"),
                                InkWell(onTap: (){
                                  defaultNavigatorTo(context,widget: ChatRegisterScreen());
                                }, child: const Text(" Register Now",style: TextStyle(color: Colors.white),)),
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
