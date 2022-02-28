
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:wether_app/models/weatherModels/weather_model.dart';
import 'package:wether_app/shared/dio_helper.dart';
import 'package:wether_app/screens/weatherApp/cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(InitWeatherStates());

  static WeatherCubit get(context) => BlocProvider.of(context);
  int? cityId;
  WeatherModel ? weatherModel;
  String? nameCity;
  String baseUrl = 'https://www.metaweather.com/';

  void getCityId({required String cityName}) {
    Uri url = Uri.parse('$baseUrl/api/location/search/?query=$cityName');
    http.get(url).then((value) {
      List<dynamic> data = jsonDecode(value.body);
      cityId = data[0]['woeid'];
      nameCity = cityName;
      getCityWeather();
      emit(GetIdWeatherSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetIdWeatherErrorStates());
    });
  }

  void getCityWeather() {
    emit(GetWeatherLoadingStates());
    Uri url = Uri.parse('$baseUrl/api/location/$cityId/');
    http.get(url).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      Map<String, dynamic> data = jsonData['consolidated_weather'][0];
      weatherModel = WeatherModel.fromJson(data);
      print(weatherModel!.temp);
      emit(GetWeatherSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetWeatherErrorStates());
    });
  }

  List search = [];

  void getSearch({required String value}) {
    emit(GetWeatherSearchLoadingStates());
    search = [];
    DioHelper.getData(path: 'api/location/search/',query: {
      'query':value,
    },).then((value) {
      search.add(value.data['title']);
      print(search);
      emit(GetWeatherSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetWeatherSearchErrorStates());
    });
  }
}
