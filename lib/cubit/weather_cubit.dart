import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherRepository weatherRepository;
  WeatherCubit({this.weatherRepository}) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());

      final weather = await weatherRepository.fetchWeather(cityName);

      emit(WeatherLoaded(weather: weather));
    } on NetworkException {
      emit(WeatherError(message: "Something went wrong..."));
    }
  }
}
