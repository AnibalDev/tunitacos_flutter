import 'package:tunitacos_flutter/models/ingredient.dart';
import 'package:tunitacos_flutter/models/owner.dart';

class TacoModel {
  //TODO agregar url
  late String nombre;
  IngredientModel? tortilla;
  List<IngredientModel?> carnes = [];
  List<IngredientModel?> picadillos = [];
  List<IngredientModel?> salsas = [];
  List<IngredientModel?> otros = [];

  late int baseValue;
  late OwnerModel owner;
  late String? uri;
  late int cantidad;

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
    //if(map.containsKey(key))
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
      if (picadillos.length < 1)
        'Picadillos': otros.map((e) => e?.toMap()).toList(),
      if (salsas.length < 1) 'Salsas': otros.map((e) => e?.toMap()).toList(),
      if (otros.length < 1) 'Otros': otros.map((e) => e?.toMap()).toList(),
      'Precio': baseValue < precio ? precio : baseValue,
      'Owner': owner.toMap(),
    };
  }
}
