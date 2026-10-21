
import 'package:aula_05/services/camera_service.dart';
import 'package:flutter/foundation.dart';

class ImageController extends ChangeNotifier {
  final CameraService _service = CameraService();
  bool loading = false;
  Uint8List? _image;
  Uint8List? get image => _image;

  Future<void> getImageGallery() async {
    loading = true;
    notifyListeners();
    final novo = await _service.callGallery();
    if (novo != null) _image = novo;
    loading = false;
    notifyListeners();
  }

  Future<void> getImageCam() async {
    loading = true;
    notifyListeners();
    final novo = await _service.callCam();
    if (novo != null) _image = novo;
    loading = false;
    notifyListeners();
  }
}