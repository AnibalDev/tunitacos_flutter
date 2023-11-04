import 'dart:convert';
import 'dart:developer';

import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/models/pedido_Model.dart';
import 'package:tunitacos_flutter/models/services/database_service.dart';
import 'package:tunitacos_flutter/models/services/tunitacos_service.dart';
import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/taco.dart';

class TunitacosRepository {
  final MongoService _tacoService = TacoService();

  Future<List<IngredientModel>> fetchIngredientList() async {
    dynamic response = await _tacoService.getCollection('ingredientes');
    List<IngredientModel> ingredientList = response
        .map<IngredientModel>((tagJson) => IngredientModel.fromMap(tagJson))
        .toList();
    return ingredientList;
  }

  Future fetchState() async {
    dynamic response = await _tacoService.getPedidoState();
    List<PedidoModel> pedidos = response
        .map<PedidoModel>((tagJson) => PedidoModel.fromMap(tagJson))
        .toList();
    return pedidos.where((element) => element.cliente?.ownerId == MongoRealmsConfig().myId).first.estado;
  }

  Future<List<TacoModel>> fetchTacosList() async {
    dynamic responde = await _tacoService.getCollection('tacos');
    List<TacoModel> tacosList = responde
        .map<TacoModel>((tagJson) => TacoModel.fromMap(tagJson))
        .toList();
    return tacosList;
  }

  Future<void> insertPedido(PedidoModel pedido) async {
    Map<String, dynamic> collection = pedido.toMap();
    _tacoService.insertCollection('pedidos', collection);
  }

  Future<void> shareTaco(TacoModel taco) async {
    Map<String, dynamic> collection = taco.toMap();
    _tacoService.insertCollection('tacos', collection);
  }
}
