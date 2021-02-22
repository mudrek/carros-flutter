import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favorito/favorito_service.dart';
import 'package:flutter/material.dart';

class FavoritoModel extends ChangeNotifier {
  List<Carro> carros = [];

  Future<List<Carro>> getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();

    return carros;
  }
}
