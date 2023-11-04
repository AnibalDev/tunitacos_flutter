class IngredientModel {
  late String nombre;
  late int precio;
  late String tipo;

  IngredientModel(
      {required this.nombre, required this.precio, required this.tipo});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      nombre: map['Nombre'] as String,
      precio: map['Precio'] as int,
      tipo: map['Tipo'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Nombre': nombre,
      'Precio': precio,
      'Tipo': tipo,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientModel &&
          runtimeType == other.runtimeType &&
          nombre == other.nombre;

  @override
  int get hashCode => nombre.hashCode;
}
