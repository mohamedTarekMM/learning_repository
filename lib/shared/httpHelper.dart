import 'package:http/http.dart' as http;

class HttpHelper {
  String baseUrl = 'https://www.metaweather.com/';

  getData({required String path,Map<String, String>? query,
  }) {
    Uri url = Uri.parse(path);
    http.get(url, headers:query);
  }
}