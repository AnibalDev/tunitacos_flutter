//import 'dart:html';

import 'package:tunitacos_flutter/models/owner.dart';
import 'package:tunitacos_flutter/models/taco.dart';

class PedidoModel {
  var tacosList = <TacoModel>[];
  late String direccion;
  late String payMethod;
  late String? estado;
  late OwnerModel? cliente;
  late String telefono;

  Map<String, dynamic> toMap() {
    return {
      'Tacos': tacosList.map((e) => e.toMap()).toList(),
      'Cliente': cliente?.toMap(),
      'Direccion': direccion,
      'PayMethod': payMethod,
      'Telefono': telefono,
      'Estado': 'Espera'
    };
  }

  PedidoModel({this.estado, this.cliente});

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    //if(map.containsKey(key))
    return PedidoModel(
        estado: map['Estado'] as String,
        cliente: OwnerModel.fromMap(map['Cliente']));
  }
}
