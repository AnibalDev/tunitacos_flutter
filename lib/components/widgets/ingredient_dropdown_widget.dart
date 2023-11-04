import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/models/ingredient.dart';

class IngredienteDropDown extends StatelessWidget {
  const IngredienteDropDown(
      {super.key,
      required this.initial,
      required this.ingredientList,
      required this.callback,
      required this.label});
  final IngredientModel? initial;
  final List<IngredientModel> ingredientList;
  final ValueSetter<IngredientModel?> callback;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<IngredientModel>(
      initialSelection: initial,
      menuStyle:
          MenuStyle(surfaceTintColor: MaterialStateProperty.all(Colors.white)),
      width: 300,
      dropdownMenuEntries: ingredientList
          .map(
            (e) => DropdownMenuEntry(
              value: e,
              label: e.nombre,
            ),
          )
          .toList(),
      label: Text(label),
      onSelected: (IngredientModel? value) {
        callback(value);
      },
    );
  }
}