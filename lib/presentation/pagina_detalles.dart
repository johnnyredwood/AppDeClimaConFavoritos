import 'package:flutter/material.dart';
import 'package:flutter_4_bloc_cubit_clima/data/clima_modelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logica/clima_cubit.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles Clima')),
      body: Center(
        child: BlocBuilder<CubitClima, EstadoClima>(
          builder: (context, state) {
            if (state.ciudad.isEmpty) {
              return Text('Data no disponible');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ciudad: ${state.ciudad}', style: TextStyle(fontSize: 24)),
                Text('Temperatura: ${state.temperatura} °C',
                    style: TextStyle(fontSize: 24)),
                Text('Nubosidad: ${state.clouds} cloudiness %',
                    style: TextStyle(fontSize: 24)),
                Text('Humedad: ${state.humidity} humidity %',
                    style: TextStyle(fontSize: 24)),
                Text('Velocidad de Viento: ${state.windSpeed} m/s',
                    style: TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}
