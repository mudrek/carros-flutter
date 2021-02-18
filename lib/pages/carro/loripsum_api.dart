import 'package:carros/utils/network.dart';
import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = "https://loripsum.net/api";

    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "replace");
    text = text.replaceAll("</p>", "replace");

    return text;
  }
}
