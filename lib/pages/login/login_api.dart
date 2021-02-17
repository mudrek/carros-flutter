import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

      final params = {
        'username': login,
        'password': senha,
      };

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      String sParams = json.encode(params);

      print("> $sParams");

      var response = await http.post(url, body: sParams, headers: headers);
      print('< Response status: ${response.statusCode}');
      print('< Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        Usuario user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      print("Erro ao fazer login, $error >> $exception");
      return ApiResponse.error(
          "Não foi possível fazer o login, tente novamente mais tarde");
    }
  }
}
