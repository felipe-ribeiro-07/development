import 'package:aula_05/services/auth_service.dart';
import 'package:aula_05/services/session_service.dart';
import 'package:flutter/foundation.dart';

class AuthController extends ChangeNotifier {
  int idLogado = 0;
  bool carregando = false;
  String erro = '';

  Future<bool> autenticarUsuario(String email, String senha) async {
    carregando = true;
    erro = '';
    notifyListeners();
    try {
      final Map resposta = await AuthService().autenticar(email, senha);
      debugPrint('Resposta do login: $resposta');

      // Aceita {data: {token, usuario}} ou {token, usuario}
      final Map dados = (resposta['data'] ?? resposta) as Map;
      final String? token = dados['token'];
      debugPrint('Token: $token');

      if (token == null) {
        erro = 'Login ou senha inválidos!';
        return false;
      }

      await SessionService().salvarToken(token);
      debugPrint('Token salvo');
      await SessionService().salvarUsuario(dados['usuario']);
      debugPrint('Usuário salvo');

      idLogado = dados['usuario']['id'];
      return true;
    } catch (e, stack) {
      debugPrint('Erro no login: $e\n$stack');
      erro = 'Erro: ${e.toString()}';
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> deslogarUsuario() async {
    await SessionService().logout();
    idLogado = 0;
    notifyListeners();
  }
}