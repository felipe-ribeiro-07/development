import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> callGallery() async {
    final XFile? imagem = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imagem == null) return null;
    return imagem.readAsBytes();
  }

  Future<Uint8List?> callCam() async {
    final XFile? imagem = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (imagem == null) return null;
    return imagem.readAsBytes();
  }
}