import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/models/pedido_Model.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/models/tunitacos_repository.dart';

class PedidoViewModel extends ChangeNotifier {
  var pedidoModel = PedidoModel();
  dynamic state;

  void ingresarTaco(TacoModel taco) {
    pedidoModel.tacosList.add(taco);
    notifyListeners();
  }

  bool get hasData => pedidoModel.tacosList.isNotEmpty;
  int get lenght {
    return hasData ? pedidoModel.tacosList.length : 0;
  }

  Future<void> pushNewPedido() async {
    try {
      await TunitacosRepository().insertPedido(pedidoModel);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  PedidoViewModel() {
    fetchStateData();
  }

  Future<void> fetchStateData() async {
    try {
      state = await TunitacosRepository().fetchState();
      log(state);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
