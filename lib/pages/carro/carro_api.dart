import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/upload_api.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/http_helper.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    var url =
        'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';

    print("GET > $url");

    var response = await http.get(url);

    List list = convert.json.decode(response.body);

    return list.map((e) => Carro.fromMap(e)).toList();
  }

  static Future<ApiResponse<Carro>> saveOrUpdate(Carro carro, File file) async {
    try {

      if(file != null) {
        ApiResponse<String> response = await UploadApi.upload(file);
        if(response.ok) {
          String urlFoto = response.result;
          carro.urlFoto = urlFoto;
        }
      }

      var url = 'http://carros-springboot.herokuapp.com/api/v2/carros';

      if (carro.id != null) {
        url += "/${carro.id}";
      }

      print("POST/PUT > $url");

      String json = carro.toJson();

      var response = await (carro.id != null
          ? http.put(url, body: json)
          : http.post(url, body: json));

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        Carro carroSaved = Carro.toObject(response.body);
        print("Carro salvado: ${carroSaved.id} - ${carroSaved.nome}");
        return ApiResponse.ok(carroSaved);
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (error) {
      print(error);
      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }

  static Future<ApiResponse<bool>> delete(Carro carro) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';

      print("DELETE > $url");

      var response = await http.delete(url);

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      if (response.statusCode == 200) {
        print("Carro salvado: deletado com sucesso.");
        return ApiResponse.ok(true);
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (error) {
      print(error);
      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }
}
