import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO {

  @override
  String get entityName => "carro";

  @override
  fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }


  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from carro where tipo =? ',[tipo]);

    return list.map<Carro>((map) => fromMap(map)).toList();
  }
}
