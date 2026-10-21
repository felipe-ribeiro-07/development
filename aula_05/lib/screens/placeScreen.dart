import 'package:aula_05/controller/lugares_controller.dart';
import 'package:aula_05/screens/cadastroLugar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Placescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Placescreen> createState() => _PlacescreenState();
}

class _PlacescreenState extends State<Placescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lugares")),
      body: Consumer<LugaresController>(
        builder: (context, lugaresController, child) {
          if (lugaresController.loading == true) {
            return Center(child: CircularProgressIndicator());
          }

          if (lugaresController.error != '') {
            return Center(child: Text(lugaresController.error));
          }

          if (lugaresController.places.isEmpty) {
            return Center(child: Text("Nada a ser exibido!"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: lugaresController.places.length,
                  itemBuilder: (context, index) {
                    final place = lugaresController.places[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        onTap: () {},
                        title: Text(place.nome),
                        subtitle: Text(place.categoria.toString()),
                        leading: CircleAvatar(
                          child: Icon(CupertinoIcons.placemark),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.heart),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Cadastrolugar (),
                        ),
                      );
                    },
                    child: const Text('Ir para outra página'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
