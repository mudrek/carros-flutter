import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_api.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/utils/network.dart';
import 'package:carros/utils/simple_bloc.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {
  List<Carro> carros;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool networkOn = await isNetworkOn();
      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> carros = await CarroApi.getCarros(tipo);
      add(carros);

      var dao = CarroDAO();
      carros.forEach(dao.save);

      return carros;
    } catch (error) {
      stream != null ? addError(error) : null;
    }
  }
}
