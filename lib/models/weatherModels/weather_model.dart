import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  String weatherStateName;
  String date;
  double minTemp;
  double maxTemp;
  double temp;

  WeatherModel({required this.weatherStateName,
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.temp
  });
//factory عشان هنا اتجنب اني اعمل variable ب nullable ?
  factory WeatherModel.fromJson(Map<String, dynamic>json){
    return WeatherModel(
        weatherStateName: json['weather_state_name'],
        date: json['applicable_date'],
        minTemp: json['min_temp'],
        maxTemp: json['max_temp'],
        temp: json['the_temp']);
  }

  String getImageWeather(){
    if(weatherStateName == 'Clear' || weatherStateName == 'Light Cloud'){
      return 'assets/images/clear.png';
    }else if(weatherStateName == 'Sleet'||weatherStateName == 'Snow'||weatherStateName == 'Hail'){
      return 'assets/images/snow.png';
    }else if(weatherStateName == 'Heavy Cloud'){
      return 'assets/images/cloudy.png';
    }else if(weatherStateName == 'Light Rain'||weatherStateName == 'Heavy Rain'||weatherStateName == 'Showers'){
      return 'assets/images/rainy.png';
    }else if(weatherStateName == 'Thunderstorm' || weatherStateName == 'Thunder'){
      return 'assets/images/thunderstorm.png';
    }else{
      return 'assets/images/clear.png';
    }
  }

  Color getColorWeather(){
    if(weatherStateName == 'Clear' || weatherStateName == 'Light Cloud'){
      return Colors.orange;
    }else if(weatherStateName == 'Sleet'||weatherStateName == 'Snow'||weatherStateName == 'Hail'){
      return Colors.blue;
    }else if(weatherStateName == 'Heavy Cloud'){
      return Colors.blueGrey;
    }else if(weatherStateName == 'Light Rain'||weatherStateName == 'Heavy Rain'||weatherStateName == 'Showers'){
      return Colors.blue;
    }else if(weatherStateName == 'Thunderstorm' || weatherStateName == 'Thunder'){
      return Colors.deepPurple;
    }else{
      return Colors.orange;
    }
  }

}
