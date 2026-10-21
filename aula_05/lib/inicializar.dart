import 'package:aula_05/controller/auth_controller.dart';
import 'package:aula_05/controller/image_controller.dart';
import 'package:aula_05/controller/lugares_controller.dart';
import 'package:aula_05/controller/themeController.dart';
import 'package:aula_05/controller/usuario_controller.dart';
import 'package:aula_05/screens/cadastroLugar.dart';
import 'package:aula_05/screens/cadastroUsuario.dart';
import 'package:aula_05/screens/homeScreen.dart';
import 'package:aula_05/screens/login.dart';
import 'package:aula_05/screens/placeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inicializar extends StatelessWidget {
  const Inicializar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (_) => LugaresController()),
        ChangeNotifierProvider(create: (context) => ImageController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => UsuarioController())
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'login',
          theme: ThemeController.construirTema(Brightness.light),
          darkTheme: ThemeController.construirTema(Brightness.dark),
          themeMode: themeController.temaAtual,
          routes: {
            'home': (context) => const Homescreen(),
            'lugares': (context) => const Placescreen(),
            'cadastro_lugar' : (context) =>  const Cadastrolugar(),
            'login':(context) => const Login(),
            'cadastro_user':(context) => Cadastrousuario()
          },
        ),
      ),
    );
  }
}
