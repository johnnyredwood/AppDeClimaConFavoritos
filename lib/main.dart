import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logica/clima_cubit.dart';
import 'data/clima_repositorio.dart';
import 'presentation/pagina_principal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env"); // or your custom file name
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitClima(ClimaRepositorio()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de Clima',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PaginaPresentacion(),
      ),
    );
  }
}
