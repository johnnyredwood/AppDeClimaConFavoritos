import 'clima_dataProvider.dart';

class ClimaRepositorio {
  final ClimaServicio api = ClimaServicio();

  Future<double> getWeather(String ciudad) async {
    try {
      return await api.getTemperature(ciudad);
    } catch (e) {
      throw Exception("Error en el repositorio: ${e.toString()}");
    }
  }

  Future<double> getTemperature(String ciudad) => api.getTemperature(ciudad);
  Future<double> getHumidity(String ciudad) => api.getHumidity(ciudad);
  Future<double> getNubosity(String ciudad) => api.getNubosity(ciudad);
  Future<double> getWindSpeed(String ciudad) => api.getWindSpeed(ciudad);
}
