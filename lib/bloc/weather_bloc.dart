import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_bloc/data/my_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, yield) async{
      print("1");
      emit(WeatherLoading());
      print("2");
      try{
        WeatherFactory wf = WeatherFactory(API_KEY,language:Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
        print(weather);
        print("srdxyh");
        emit(WeatherSuccess(weather));
      }catch(e){
        print("3");
        emit(WeatherFailure());
      }
    });
  }
}
