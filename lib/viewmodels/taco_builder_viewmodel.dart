import 'package:flutter/widgets.dart';
import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/models/tunitacos_repository.dart';

class TacoBuilderViewModel extends ChangeNotifier {
  late TacoModel selectedTaco;

  TacoBuilderViewModel() {
    selectedTaco = TacoModel.newTaco();
  }

  set setTaco(TacoModel tm) {
    selectedTaco = tm;
  }

  IngredientModel? get selectedTortilla {
    return selectedTaco.tortilla == null ? selectedTaco.tortilla : null;
  }

  List<IngredientModel?> get selectedCarnes => selectedTaco.carnes;
  List<IngredientModel?> get selectedPicadillos => selectedTaco.picadillos;
  List<IngredientModel?> get selectedSalsas => selectedTaco.salsas;
  List<IngredientModel?> get selectedOtros => selectedTaco.otros;

  Future<void> shareTaco(TacoModel taco) async {
    try {
      await TunitacosRepository().shareTaco(taco);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
