import 'package:flutter_4_bloc_cubit_clima/data/clima_modelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/clima_repositorio.dart';

//BloC cubit
class CubitClima extends Cubit<EstadoClima> {
  final ClimaRepositorio repository;
//contructor del provider cubit
  CubitClima(this.repository) : super(EstadoClima());
// metodo del provider cubit
  void obtenerClima(String ciudad) async {
    emit(EstadoClima(ciudad: ciudad, estaCargando: true));
    try {
      final temp = await repository.getWeather(ciudad);
      final humidity = await repository.getHumidity(ciudad);
      final nubosity = await repository.getNubosity(ciudad);
      final windSpeed = await repository.getWindSpeed(ciudad);
      emit(EstadoClima(
          ciudad: ciudad,
          temperatura: temp,
          estaCargando: false,
          clouds: nubosity,
          humidity: humidity,
          windSpeed: windSpeed));
    } catch (e) {
      emit(EstadoClima(
          ciudad: ciudad, estaCargando: false, error: e.toString()));
    }
  }
}
