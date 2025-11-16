import '../../dominio/entidades/paisfavorito.dart';

class PaisFavoritoModelo extends PaisFavorito {
  PaisFavoritoModelo({required super.id, required super.nombre});

//Convierte un Map en un objeto UsuarioModel (utilizado en la pagina_principal).
  factory PaisFavoritoModelo.fromMap(Map<String, dynamic> map) {
    return PaisFavoritoModelo(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
//Convierte un objeto UsuarioModel a un Map para insertarlo o actualizarlo en la base de datos.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nombre': nombre,
    };

    // Solo agrega 'id' si es diferente de 0 o no nulo (este numero es creado por la base de datos para cada usuario)
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }
}
