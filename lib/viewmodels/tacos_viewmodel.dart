import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/models/tunitacos_repository.dart';
import 'package:tunitacos_flutter/models/taco.dart';

class TacoViewModel extends ChangeNotifier {
  var tacosList = <TacoModel>[];

  List<TacoModel> get catalogoCarta =>
      tacosList.where((taco) => taco.owner.ownerType == "Carta").toList();
  List<TacoModel> get catalogoPublico =>
      tacosList.where((taco) => taco.owner.ownerType == "Publico").toList();

  List<TacoModel> get catalogoPrivado => tacosList
      .where(
        (taco) =>
            taco.owner.ownerType == "Privado" &&
            taco.owner.ownerId == MongoRealmsConfig().myId,
      )
      .toList();

  Future<void> fetchTacosData() async {
    try {
      tacosList = await TunitacosRepository().fetchTacosList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
