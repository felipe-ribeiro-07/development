import 'package:aula_05/model/usuario_model.dart';
import 'package:aula_05/services/usuarios_service.dart';
import 'package:flutter/foundation.dart';

class UsuarioController extends ChangeNotifier {
  bool carregando = false;
  String erro = '';
  String mensagem = '';

  Future<bool> criarUsuario(UsuarioModel data) async {
  final senha = data.senha;
  if (senha == null || senha.isEmpty) {
    erro = 'Informe uma senha';
    notifyListeners();
    return false;
  }

  carregando = true;
  erro = '';
  mensagem = '';
  notifyListeners();

  try {
    final resposta = await UsuariosService().criarConta(
      nome: data.nome,
      email: data.email,
      senha: senha, // aqui já é String, sem o ?
      avatar: data.avatar,
      cidade: data.cidade,
      idade: data.idade,
      profissao: data.profissao,
      instagram: data.instagram,
      facebook: data.facebook,
      youtube: data.youtube,
      site: data.site,
      telefone: data.telefone,
    );

    mensagem = resposta['message']?.toString() ?? 'Conta criada com sucesso!';
    return true;
  } catch (e) {
    debugPrint('Erro ao criar conta: $e');
    erro = e.toString().replaceFirst('Exception: ', '');
    return false;
  } finally {
    carregando = false;
    notifyListeners();
  }
}
}