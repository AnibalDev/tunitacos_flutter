import 'package:flutter/widgets.dart';
import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/models/tunitacos_repository.dart';

class TacoBuilderViewModel extends ChangeNotifier {
  Future<void> shareTaco(TacoModel taco) async {
    try {
      await TunitacosRepository().shareTaco(taco);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
