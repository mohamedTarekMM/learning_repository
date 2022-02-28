import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/models/weatherModels/weather_model.dart';
import 'package:wether_app/screens/weatherApp/city_screen.dart';
import 'package:wether_app/shared/components.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_cubit.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_state.dart';

import '../../screens/weatherApp/searchScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WeatherCubit.get(context).weatherModel;
        return BlocConsumer<WeatherCubit,WeatherState>(
          listener: (context,state){
            if(state is GetWeatherLoadingStates){
              Center(child: CircularProgressIndicator());
            }
          },
          builder: (context,state){
            var cubit = WeatherCubit.get(context);
            return Scaffold(
              //backgroundColor: Colors.deepOrange,
              appBar: AppBar(
                backgroundColor:WeatherCubit.get(context).weatherModel != null?WeatherCubit.get(context).weatherModel!.getColorWeather():Theme.of(context).primaryColor,
                title: const Text('Weather'),
                actions: [
                  IconButton(
                      onPressed: () {
                        defaultNavigatorTo(context, widget: SearchScreen());
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        defaultNavigatorTo(context, widget: CityScreen());
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              body: ConditionalBuilder(
                condition: cubit.weatherModel != null,
                builder: (context)=>weatherItems(context),
                fallback: (context)=>Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                       Text('You Must Search Of City at first'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
  Widget weatherItems(context)=>Center(
    child: Container(
      color: WeatherCubit.get(context).weatherModel!.getColorWeather(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '${WeatherCubit.get(context).nameCity}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                WeatherCubit.get(context).weatherModel!.date,
                style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15,),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  WeatherCubit.get(context).weatherModel!.getImageWeather(),
                  height: 50,width: 50,),
                Text(
                  '${WeatherCubit.get(context).weatherModel!.temp.round()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'max : ${WeatherCubit.get(context).weatherModel!.maxTemp.round()}',
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
                    ),
                    Text(
                      'min : ${WeatherCubit.get(context).weatherModel!.minTemp.round()}',
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            WeatherCubit.get(context).weatherModel!.weatherStateName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ],
      ),
    ),
  );
}
