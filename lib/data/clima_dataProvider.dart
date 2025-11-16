import 'dart:convert';
import 'package:http/http.dart' as http; // Importación correcta

//Data Provider
class ClimaServicio {
  static const String apiKey =
      '06d231829dff207ff309f4c129ae62ca'; //  Nueva API Key
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> _fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener el clima: ${response.reasonPhrase}');
    }
  }

  Future<double> obtenerClima(String city) async {
    final data = await _fetchWeather(city);
    final temp = (data['main']['temp']) as num;
    return temp.toDouble();
  }

  Future<double> obtenerHumedad(String city) async {
    final data = await _fetchWeather(city);
    final humidity = (data['main']['humidity']) as num;
    return humidity.toDouble();
  }

  Future<double> obtenerNubosity(String city) async {
    final data = await _fetchWeather(city);
    final clouds = (data['clouds']['all']) as num;
    return clouds.toDouble();
  }

  Future<double> obtenerWindSpeed(String city) async {
    final data = await _fetchWeather(city);
    final speed = (data['wind']['speed']) as num;
    return speed.toDouble();
  }

  Future<double> getTemperature(String city) => obtenerClima(city);
  Future<double> getHumidity(String city) => obtenerHumedad(city);
  Future<double> getNubosity(String city) => obtenerNubosity(city);
  Future<double> getWindSpeed(String city) => obtenerWindSpeed(city);
}
