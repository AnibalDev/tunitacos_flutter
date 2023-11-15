import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/owner.dart';

class TacoModel {
  String? nombre;
  IngredientModel? tortilla;
  List<IngredientModel?> carnes = [];
  List<IngredientModel?> picadillos = [];
  List<IngredientModel?> salsas = [];
  List<IngredientModel?> otros = [];

  late int baseValue;
  late OwnerModel owner;
  late String? uri;
  int cantidad = 1;

  int get precio {
    return tortilla!.precio +
        carnes
            .fold(
                0, (previousValue, element) => previousValue + element!.precio)
            .round() +
        picadillos
            .fold(
                0, (previousValue, element) => previousValue + element!.precio)
            .round() +
        salsas
            .fold(
                0, (previousValue, element) => previousValue + element!.precio)
            .round() +
        otros
            .fold(
                0, (previousValue, element) => previousValue + element!.precio)
            .round();
  }

  TacoModel.newTaco();

  TacoModel(
      {required this.nombre,
      required this.tortilla,
      required this.carnes,
      required this.picadillos,
      required this.salsas,
      required this.otros,
      required this.baseValue,
      required this.owner,
      this.cantidad = 1,
      this.uri});

  factory TacoModel.fromMap(Map<String, dynamic> map) {
    return TacoModel(
      uri: map['Uri'] as String?,
      nombre: map['Nombre'] as String,
      tortilla: IngredientModel.fromMap(map['Tortilla']),
      carnes: map['Carnes']
          .map<IngredientModel>((ing) => IngredientModel.fromMap(ing))
          .toList(),
      picadillos: map.containsKey('Picadillos')
          ? map['Picadillos']
              .map<IngredientModel>((ing) => IngredientModel.fromMap(ing))
              .toList()
          : [],
      salsas: map.containsKey('Salsas')
          ? map['Salsas']
              .map<IngredientModel>((ing) => IngredientModel.fromMap(ing))
              .toList()
          : [],
      otros: map.containsKey('Otros')
          ? map['Otros']
              .map<IngredientModel>((ing) => IngredientModel.fromMap(ing))
              .toList()
          : [],
      baseValue: map['Precio'] as int,
      owner: OwnerModel.fromMap(map['Owner']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Cantidad': cantidad,
      'Nombre': nombre,
      'Tortilla': tortilla!.toMap(),
      'Carnes': carnes.map((e) => e?.toMap()).toList(),
      if (picadillos.isNotEmpty)
        'Picadillos': picadillos.map((e) => e?.toMap()).toList(),
      if (salsas.isNotEmpty) 'Salsas': salsas.map((e) => e?.toMap()).toList(),
      if (otros.isNotEmpty) 'Otros': otros.map((e) => e?.toMap()).toList(),
      'Precio': baseValue < precio ? precio : baseValue,
      'Owner': owner.toMap(),
    };
  }
}
