import 'package:carros/pages/api_response.dart';
import 'package:carros/utils/simple_bloc.dart';

import 'login_api.dart';

class LoginBloc extends SimpleBloc<bool> {
  login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}
