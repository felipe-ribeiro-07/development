import 'package:aula_05/controller/usuario_controller.dart';
import 'package:aula_05/model/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cadastrousuario extends StatefulWidget {
  const Cadastrousuario({super.key});

  @override
  State<Cadastrousuario> createState() => _CadastrousuarioState();
}

class _CadastrousuarioState extends State<Cadastrousuario> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _profissaoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _siteController = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _cidadeController.dispose();
    _idadeController.dispose();
    _profissaoController.dispose();
    _telefoneController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _youtubeController.dispose();
    _siteController.dispose();
    super.dispose();
  }

  // ---------- Validações ----------

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe seu nome';
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe seu e-mail';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) return 'E-mail inválido';
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe uma senha';
    if (value.length < 6) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  String? _validarConfirmacao(String? value) {
    if (value == null || value.isEmpty) return 'Confirme sua senha';
    if (value != _senhaController.text) return 'As senhas não coincidem';
    return null;
  }

  String? _validarIdade(String? value) {
    if (value == null || value.trim().isEmpty) return null; // opcional
    final idade = int.tryParse(value.trim());
    if (idade == null || idade < 0 || idade > 120) return 'Idade inválida';
    return null;
  }

  // ---------- Ações ----------

  /// Retorna null se o campo estiver vazio, para não enviar "" para a API.
  String? _opcional(TextEditingController c) {
    final texto = c.text.trim();
    return texto.isEmpty ? null : texto;
  }

  Future<void> _cadastrar(UsuarioController controller) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final usuario = UsuarioModel(
      id: 0, // o id real é gerado pelo servidor
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      senha: _senhaController.text,
      cidade: _opcional(_cidadeController),
      idade: int.tryParse(_idadeController.text.trim()),
      profissao: _opcional(_profissaoController),
      telefone: _opcional(_telefoneController),
      instagram: _opcional(_instagramController),
      facebook: _opcional(_facebookController),
      youtube: _opcional(_youtubeController),
      site: _opcional(_siteController),
    );

    final sucesso = await controller.criarUsuario(usuario);

    if (!mounted) return;

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.mensagem)),
      );
      Navigator.pop(context); // volta para o login
    }
  }

  // ---------- Widgets auxiliares ----------

  Widget _titulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required IconData icone,
    String? Function(String?)? validator,
    TextInputType? teclado,
    TextInputAction acao = TextInputAction.next,
    TextCapitalization capitalizacao = TextCapitalization.none,
    bool ocultar = false,
    Widget? sufixo,
    void Function(String)? aoEnviar,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: teclado,
        textInputAction: acao,
        textCapitalization: capitalizacao,
        obscureText: ocultar,
        onFieldSubmitted: aoEnviar,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icone),
          suffixIcon: sufixo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // ---------- Tela ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: Consumer<UsuarioController>(
        builder: (context, controller, _) => Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _titulo('Dados de acesso'),
                    const SizedBox(height: 16),
                    _campo(
                      controller: _nomeController,
                      label: 'Nome',
                      icone: Icons.person_outline,
                      validator: _validarNome,
                      capitalizacao: TextCapitalization.words,
                    ),
                    _campo(
                      controller: _emailController,
                      label: 'E-mail',
                      icone: Icons.email_outlined,
                      validator: _validarEmail,
                      teclado: TextInputType.emailAddress,
                    ),
                    _campo(
                      controller: _senhaController,
                      label: 'Senha',
                      icone: Icons.lock_outline,
                      validator: _validarSenha,
                      ocultar: _ocultarSenha,
                      sufixo: IconButton(
                        icon: Icon(
                          _ocultarSenha
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _ocultarSenha = !_ocultarSenha),
                      ),
                    ),
                    _campo(
                      controller: _confirmarSenhaController,
                      label: 'Confirmar senha',
                      icone: Icons.lock_outline,
                      validator: _validarConfirmacao,
                      ocultar: _ocultarConfirmacao,
                      sufixo: IconButton(
                        icon: Icon(
                          _ocultarConfirmacao
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(
                          () => _ocultarConfirmacao = !_ocultarConfirmacao,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _titulo('Sobre você (opcional)'),
                    const SizedBox(height: 16),
                    _campo(
                      controller: _cidadeController,
                      label: 'Cidade',
                      icone: Icons.location_city_outlined,
                      capitalizacao: TextCapitalization.words,
                    ),
                    _campo(
                      controller: _idadeController,
                      label: 'Idade',
                      icone: Icons.cake_outlined,
                      validator: _validarIdade,
                      teclado: TextInputType.number,
                    ),
                    _campo(
                      controller: _profissaoController,
                      label: 'Profissão',
                      icone: Icons.work_outline,
                      capitalizacao: TextCapitalization.sentences,
                    ),
                    _campo(
                      controller: _telefoneController,
                      label: 'Telefone',
                      icone: Icons.phone_outlined,
                      teclado: TextInputType.phone,
                    ),
                    _campo(
                      controller: _instagramController,
                      label: 'Instagram',
                      icone: Icons.alternate_email,
                    ),
                    _campo(
                      controller: _facebookController,
                      label: 'Facebook',
                      icone: Icons.facebook_outlined,
                    ),
                    _campo(
                      controller: _youtubeController,
                      label: 'YouTube',
                      icone: Icons.play_circle_outline,
                    ),
                    _campo(
                      controller: _siteController,
                      label: 'Site',
                      icone: Icons.language,
                      teclado: TextInputType.url,
                      acao: TextInputAction.done,
                      aoEnviar: (_) => _cadastrar(controller),
                    ),
                    const SizedBox(height: 8),
                    if (controller.erro.isNotEmpty) ...[
                      Text(
                        controller.erro,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    FilledButton(
                      onPressed: controller.carregando
                          ? null
                          : () => _cadastrar(controller),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: controller.carregando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Criar conta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}