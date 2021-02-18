import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/utils/network.dart';
import 'package:carros/utils/simple_bloc.dart';

class LoripsumBloc extends SimpleBloc<String> {

  String text;

  void fetch() async {
    try {
      bool networkOn = await isNetworkOn();
      if(!networkOn) {
        throw new Exception("Sem conexão com a internet");
      } else {
        String text = await LoripsumApi.getLoripsum();
        add(text);
      }
    } catch (error) {
      addError(error);
    }
  }

}