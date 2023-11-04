import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/tunitacos_repository.dart';

class IngredientViewModel extends ChangeNotifier {
  var ingredientsList = <IngredientModel>[];

  List<IngredientModel> get tortillasList =>
      ingredientsList.where((element) => element.tipo == "Tortilla").toList();
  List<IngredientModel> get carnesList =>
      ingredientsList.where((element) => element.tipo == "Carne").toList();
  List<IngredientModel> get picadillosList =>
      ingredientsList.where((element) => element.tipo == "Picadillo").toList();
  List<IngredientModel> get salsasList =>
      ingredientsList.where((element) => element.tipo == "Salsa").toList();
  List<IngredientModel> get otrosList =>
      ingredientsList.where((element) => element.tipo == "Otros").toList();

  bool get hasData => ingredientsList.isNotEmpty;

  IngredientViewModel() {
    fetchMediaData();
  }

  Future<void> fetchMediaData() async {
    try {
      ingredientsList = await TunitacosRepository().fetchIngredientList();
    } catch (e) {
    }
    notifyListeners();
  }
}
