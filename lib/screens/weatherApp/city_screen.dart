import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components.dart';
import 'cubit/weather_cubit.dart';
import 'cubit/weather_state.dart';

class CityScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherState>(
      listener: (context,state){
        // if(state is GetWeatherSuccessStates){
        //   defaultNavigateAndKill(context,HomeScreen());
        // }
      },
      builder: (context,state){
        var list = WeatherCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search a City'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultTextForm(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  label: 'Search',
                  onChanged: (String value){
                    value = searchController.text;
                    WeatherCubit.get(context).getSearch(value: value);
                  },
                  prefixIcon: Icons.search,
                  outlineInputBorder: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context,index)=>articleBuilder(list[index],context),
                    separatorBuilder: (context,index)=>myDivider(),
                    itemCount: list.length
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget articleBuilder(list, context,) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>titleItems(list[index]),
        separatorBuilder: (context, index) => SizedBox(height: 5,),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
  Widget titleItems(search)=>Column(
    children: [
      Text(search['title']),
    ],
  );

}
