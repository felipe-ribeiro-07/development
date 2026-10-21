import 'package:aula_05/controller/image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cadastrolugar extends StatefulWidget {
  const Cadastrolugar({super.key});

  @override
  State<Cadastrolugar> createState() => _CadastrolugarState();
}

class _CadastrolugarState extends State<Cadastrolugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar lugar')),
      body: Consumer<ImageController>(
        builder: (context, imageController, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    image: showImage(imageController),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 8,
                  child: IconButton(
                    onPressed: () => openModal(imageController, context),
                    icon: const Icon(CupertinoIcons.camera),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

DecorationImage showImage(ImageController controller) {
  if (controller.image == null) {
    return const DecorationImage(
      image: NetworkImage('https://placehold.co/600x400.png'),
      fit: BoxFit.cover,
    );
  } else {
    return DecorationImage(
      image: MemoryImage(controller.image!),
      fit: BoxFit.cover,
    );
  }
}

void openModal(ImageController controller, context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SafeArea(
      bottom: true,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ListTile(
            leading: Icon(CupertinoIcons.camera),
            title: Text("Tirar foto"),
            onTap: () {
              controller.getImageCam();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.archivebox),
            title: Text("Selecionar galeria"),
            onTap: () {
              controller.getImageGallery();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
