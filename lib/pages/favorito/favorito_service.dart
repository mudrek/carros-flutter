import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favorito/favorito.dart';
import 'package:carros/pages/favorito/favorito_dao.dart';
import 'package:carros/pages/favorito/favorito_model.dart';
import 'package:provider/provider.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro c) async {
    Favorito favorito = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(favorito.id);

    if (exists) {
      print("DELETE");
      dao.delete(favorito.id);
      Provider.of<FavoritoModel>(context, listen: false).getCarros();
      return false;
    } else {
      print("INSERT");
      dao.save(favorito);
      Provider.of<FavoritoModel>(context, listen: false).getCarros();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO()
        .query("select * from carro c, favorito f where c.id = f.id");

    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();
    final exists = await dao.exists(c.id);
    return exists;
  }
}
