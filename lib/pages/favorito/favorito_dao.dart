import 'package:carros/pages/favorito/favorito.dart';

import '../../utils/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  String get entityName => "favorito";

  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }
}
