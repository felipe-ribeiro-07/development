class UsuarioModel {
  final int id;
  final String nome;
  final String email;
  final String? senha;
  final String? avatar;
  final String? cidade;
  final int? idade;
  final String? profissao;
  final String? instagram;
  final String? facebook;
  final String? youtube;
  final String? site;
  final String? telefone;

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    this.senha,
    this.avatar,
    this.cidade,
    this.idade,
    this.profissao,
    this.instagram,
    this.facebook,
    this.youtube,
    this.site,
    this.telefone,
  });

  factory UsuarioModel.fromJson(Map json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      avatar: json['avatar'],
      cidade: json['cidade'],
      idade: json['idade'],
      profissao: json['profissao'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      youtube: json['youtube'],
      site: json['site'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }
}