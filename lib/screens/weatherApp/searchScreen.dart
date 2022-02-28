import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/models/weatherModels/weather_model.dart';
import 'package:wether_app/shared/components.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_cubit.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_state.dart';

import '../../layout/weather_layout/Home_Screen.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherState>(
      listener: (context,state){
        if(state is GetWeatherSuccessStates){
          defaultNavigateAndKill(context,HomeScreen());
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search a City'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: defaultTextForm(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    onSubmitted: (String nameCity){
                      nameCity = searchController.text.trim();
                      WeatherCubit.get(context).getCityId(cityName: nameCity);
                    },
                    prefixIcon: Icons.search,
                    outlineInputBorder: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
