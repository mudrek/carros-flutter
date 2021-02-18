import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favorito/favorito_service.dart';
import 'package:carros/utils/simple_bloc.dart';

class FavoritoBloc extends SimpleBloc<List<Carro>> {

  List<Carro> carros;

  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);
      return carros;
    } catch (error) {
      addError(error);
    }
  }
}