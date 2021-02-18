import 'package:carros/pages/carro/carro.dart';
import 'package:carros/utils/sql/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {

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
