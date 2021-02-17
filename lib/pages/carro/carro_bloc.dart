import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_api.dart';
import 'package:carros/utils/simple_bloc.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {

  List<Carro> carros;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      add(carros);
      return carros;
    } catch (error) {
      addError(error);
    }
  }

}
