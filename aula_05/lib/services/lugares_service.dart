import 'dart:convert';

import 'package:aula_05/model/lugares_model.dart';
import 'package:http/http.dart' as http;

class LugaresService {
  // https://guiaturismo.onrender.com/lugares?pagina=1&limite=10
  String endPoint = "https://guiaturismo.onrender.com/lugares";
  int paginas = 1;
  int limite = 10;

  Future<List<LugaresModel>> fetchPlaces() async {
    try {
      final response = await http.get(
        Uri.parse('$endPoint?pagina=$paginas&limite=$limite'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        return data.map((item) => LugaresModel.fronJson(item)).toList();
      } else {
        throw Exception('Erro de requisição : ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> creatPlaces(LugaresModel data, token) async {
    try {
      if (token.isEmpty) {
        return "Não autorizado";
      }

      final response = await http.post(
        Uri.parse(endPoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      Map<String, dynamic> menssage = jsonDecode(response.body);
      return menssage["mensage"];
    } catch (e) {
      rethrow;
    }
  }
}
