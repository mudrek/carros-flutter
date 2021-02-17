import 'dart:convert';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    Usuario usuario = await Usuario.get();

    var url =
        'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    List list = json.decode(response.body);

    final carros = list.map((e) => Carro.fromJson(e)).toList();

    var dao = CarroDAO();

    carros.forEach(dao.save);

    return carros;
  }
}
