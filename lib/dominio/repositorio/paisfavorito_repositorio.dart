import '../../data/db/data_base.dart';
import '../../data/modelo/paisfavorito_modelo.dart';
//Esta clase implementa el Patrón Repositorio,
//lo que significa que actúa como intermediario entre
//la lógica de la aplicación y la base de datos.

class PaisFavoritoRepositorio {
  final DataBaseSqlite dbb = DataBaseSqlite();

  // Insertar un usuario
  Future<void> insertarPaisFavorito(PaisFavoritoModelo paisFavorito) async {
    final db = await dbb
        .database; //Abre o obtiene la conexión a la base de datos usando dbb (es una instancia de Database).
    await db.insert(
        'paisesfavoritos',
        paisFavorito
            .toMap()); //inserta un nuevo registro en la tabla usuarios, convierte el objeto UsuarioModel a un Map para insertarlo en la base de datos.
  }

//Método obtener Usuarios
  Future<List<PaisFavoritoModelo>> obtenerPaisesFavoritos() async {
    final db = await dbb.database; //instancia (abre conexion) a la basede datos
    final List<Map<String, dynamic>> maps = await db.query(
        'paisesfavoritos'); //recupera (query) todos los registros de la tabla usuarios, la base de datos devuelve un map
    return List.generate(maps.length, (i) {
      // convierte la lista de mapas (maps) a una lista de objetos UsuarioModel.
      return PaisFavoritoModelo.fromMap(maps[i]);
    });
  }

//Método eliminar Usuario
  Future<void> eliminarPaisFavorito(int id) async {
    final db = await dbb.database; //instancia (abrir conexion)
    await db.delete('paisesfavoritos', where: 'id = ?', whereArgs: [
      id
    ]); //where: 'id = ?' es una condición que indica que solo se eliminará el usuario cuyo id coincida.
  }

  // Actualizar un usuario
  Future<void> actualizarPaisFavorito(PaisFavoritoModelo paisFavorito) async {
    final db = await dbb.database;
    await db.update(
      'paisesfavoritos',
      paisFavorito.toMap(),
      where: 'id = ?',
      whereArgs: [paisFavorito.id],
    );
  }
}
