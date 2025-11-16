//modelo
class EstadoClima {
  final String ciudad;
  final double temperatura;
  final bool estaCargando;
  final String? error;
  final double humidity;
  final double clouds;
  final double windSpeed;

  EstadoClima(
      {this.ciudad = '',
      this.temperatura = 0.0,
      this.estaCargando = false,
      this.clouds = 0.0,
      this.humidity = 0.0,
      this.windSpeed = 0.0,
      this.error});
}
