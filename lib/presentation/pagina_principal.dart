import 'package:flutter/material.dart';
import 'package:flutter_4_bloc_cubit_clima/data/clima_modelo.dart';
import 'package:flutter_4_bloc_cubit_clima/data/modelo/paisfavorito_modelo.dart';
import 'package:flutter_4_bloc_cubit_clima/dominio/repositorio/paisfavorito_repositorio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logica/clima_cubit.dart';
import 'pagina_detalles.dart';

class PaginaPresentacion extends StatefulWidget {
  const PaginaPresentacion({super.key});

  @override
  State<PaginaPresentacion> createState() => _PaginaPresentacionState();
}

class _PaginaPresentacionState extends State<PaginaPresentacion> {
  final TextEditingController ciudadControlador = TextEditingController();

  final PaisFavoritoRepositorio paisFavoritoRepositorio =
      PaisFavoritoRepositorio();
  List<PaisFavoritoModelo> paisesFavoritos = [];

  @override
  void initState() {
    super.initState();
    _cargarPaisesFavoritos();
  }

  Future<void> _cargarPaisesFavoritos() async {
    final data = await paisFavoritoRepositorio.obtenerPaisesFavoritos();
    setState(() {
      paisesFavoritos = data; // Actualiza la lista de paises favoritos
    });
  }

  Future<void> _agregarPaisFavorito() async {
    if (ciudadControlador.text.isEmpty) return;
    final nuevoPaisFavorito =
        PaisFavoritoModelo(id: 0, nombre: ciudadControlador.text);
    await paisFavoritoRepositorio.insertarPaisFavorito(nuevoPaisFavorito);
    ciudadControlador.clear();
    _cargarPaisesFavoritos();
  }

  Future<void> _eliminarPaisFavorito(int id) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmar eliminación '),
            content: Text(
                '¿Estás seguro de que deseas eliminar este país favorito?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await paisFavoritoRepositorio.eliminarPaisFavorito(id);
                  _cargarPaisesFavoritos();
                },
                child: Text('Eliminar'),
              ),
            ],
          );
        });
  }

  Future<void> _editarPaisFavorito(PaisFavoritoModelo paisFavorito) async {
    ciudadControlador.text = paisFavorito.nombre;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar País Favorito'),
          content: TextField(
            controller: ciudadControlador,
            decoration: const InputDecoration(labelText: 'Nombre del País'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final actualizadoPaisFavorito = PaisFavoritoModelo(
                  id: paisFavorito.id,
                  nombre: ciudadControlador.text,
                );
                await paisFavoritoRepositorio
                    .actualizarPaisFavorito(actualizadoPaisFavorito);
                ciudadControlador.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                _cargarPaisesFavoritos();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App de Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ciudadControlador,
              decoration: InputDecoration(labelText: 'Ingresa la Ciudad'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<CubitClima>().obtenerClima(ciudadControlador.text);
              },
              child: Text('Consultar Clima'),
            ),
            SizedBox(height: 20),
            BlocBuilder<CubitClima, EstadoClima>(
              builder: (context, state) {
                if (state.estaCargando) {
                  return CircularProgressIndicator();
                } else if (state.error != null) {
                  return Text('Error: ${state.error}');
                } else if (state.ciudad.isNotEmpty) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city, size: 24),
                          SizedBox(width: 8),
                          Text('Ciudad: ${state.ciudad}',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thermostat, size: 24),
                          SizedBox(width: 8),
                          Text('Temperatura: ${state.temperatura} °C',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage()),
                          );
                        },
                        child: Text('Mirar Detalles'),
                      ),
                    ],
                  );
                } else {
                  return Text(' Ingresa una ciudad para consultar el clima');
                }
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _agregarPaisFavorito,
              child: Text('Guardar en Favoritos'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: paisesFavoritos.length,
                itemBuilder: (context, index) {
                  final paisFavorito = paisesFavoritos[index];
                  return Card(
                    child: ListTile(
                      title: Text(paisFavorito.nombre),
                      onTap: () {
                        ciudadControlador.text = paisFavorito.nombre;
                        context.read<CubitClima>().obtenerClima(paisFavorito.nombre);
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editarPaisFavorito(paisFavorito),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _eliminarPaisFavorito(paisFavorito.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
