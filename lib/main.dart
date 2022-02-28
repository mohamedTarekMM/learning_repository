import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/layout/chatApp/cubit/chat_cubit.dart';
import 'package:wether_app/layout/shopLayouts/cubit/shop_cubit.dart';
import 'package:wether_app/layout/weather_layout/Home_Screen.dart';
import 'package:wether_app/screens/chatApp/loginScreen/login_screen.dart';
import 'package:wether_app/screens/chatApp/registerScreen/cubit/register_cubit.dart';
import 'package:wether_app/screens/shopApp/cat_deatiels.dart';
import 'package:wether_app/screens/shopApp/updateScreen/updateScreen.dart';
import 'package:wether_app/shared/bloc_observer.dart';
import 'package:wether_app/shared/constants.dart';
import 'package:wether_app/shared/dio_helper.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_cubit.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_state.dart';
import 'package:wether_app/shared/shared_pref.dart';
import 'package:wether_app/shared/themes.dart';
import 'dart:ui';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'layout/chatApp/chat_app.dart';
import 'layout/shopLayouts/Shop_Layout.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget;
  await SharedPref.sharedInit();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  uId = SharedPref.getData(key: 'uId');
  if(uId != null){
    startWidget = ChatAppLayoutScreen();
  }else{
    startWidget = ChatLoginScreen();
  }
  runApp( MyApp(startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key,required this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()..getAllProduct()..getCategories()),
        BlocProvider(create: (context)=>WeatherCubit()),
        BlocProvider(create: (context)=>ChatLayoutsCubit()..getMessage()),
      ],
      child: BlocConsumer<WeatherCubit,WeatherState>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            routes: {
              ShopAppLayoutsScreen.id :(context)=> ShopAppLayoutsScreen(),
              UpdateScreen.id :(context)=>UpdateScreen(),
              CategoriesDetails.id:(context)=>CategoriesDetails()
            },
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: light_Theme,
            darkTheme: dark_Theme,
            themeMode: ThemeMode.light,
            initialRoute:  ShopAppLayoutsScreen.id,
          );
        },
      ),
    );
  }
}


