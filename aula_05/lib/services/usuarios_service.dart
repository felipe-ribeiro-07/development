import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuariosService {
  final String endPoint = 'https://guiaturismo.onrender.com/usuarios';

  Future<Map> criarConta({
    required String nome,
    required String email,
    required String senha,
    String? avatar,
    String? cidade,
    int? idade,
    String? profissao,
    String? instagram,
    String? facebook,
    String? youtube,
    String? site,
    String? telefone,
  }) async {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'senha': senha,
        'avatar': avatar,
        'cidade': cidade,
        'idade': idade,
        'profissao': profissao,
        'instagram': instagram ,
        'facebook': facebook,
        'youtube': youtube,
        'site': site,
        'telefone': telefone,
      }),
    );

    final Map corpo = jsonDecode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(corpo['message'] ?? 'Erro ao criar conta (${response.statusCode})');
    }

    return corpo;
  }
}