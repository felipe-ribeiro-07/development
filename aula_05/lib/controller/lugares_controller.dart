import 'package:aula_05/model/lugares_model.dart';
import 'package:aula_05/services/lugares_service.dart';
import 'package:aula_05/services/session_service.dart';
import 'package:flutter/cupertino.dart';

class LugaresController extends ChangeNotifier {

  bool loading = false;
  String error = '';
  String message = '';
  List<LugaresModel> _places = [];
  List<LugaresModel> get places => _places;

  LugaresController(){
    getPlaces();
  }

  Future<void> getPlaces () async {
    loading = true;
    notifyListeners();
    try {

      final placeService = LugaresService();
      final listPlaces = await placeService.fetchPlaces();
      _places = listPlaces;
      
    } catch (e) {
        error = 'Erro na listagem de lugares';
    } finally {
        loading = false;
        notifyListeners();
    }
  }

  Future<void> creatPlaces(LugaresModel data) async {
  final token = await SessionService().pegarToken() ?? '';
  loading = true;
  error = '';
  message = '';
  notifyListeners();

  try {
    final servicePlaces = LugaresService();
    final response = await servicePlaces.creatPlaces(data, token);
    message = response;
  } catch (e) {
    error = 'Erro ao criar';
  } finally {
    loading = false;
    notifyListeners();
  }
}

}