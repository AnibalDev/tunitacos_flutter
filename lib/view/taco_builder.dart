import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/components/widgets/ingredient_dropdown_widget.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/models/owner.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/theme/colors.dart';
import 'package:tunitacos_flutter/viewmodels/ingredient_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/taco_builder_viewmodel.dart';

class TacoBuilderPlusUltraView extends StatefulWidget {
  const TacoBuilderPlusUltraView({super.key});

  @override
  State<TacoBuilderPlusUltraView> createState() =>
      _TacoBuilderPlusUltraViewState();
}

class _TacoBuilderPlusUltraViewState extends State<TacoBuilderPlusUltraView> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taco = ModalRoute.of(context)!.settings.arguments as TacoModel;
    final ingredientsvm = Provider.of<IngredientViewModel>(context);
    final pedidovm = Provider.of<PedidoViewModel>(context);
    final buildervm = Provider.of<TacoBuilderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Construccion',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () => ingredientsvm.fetchMediaData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            '¡Seleccione sus ingredientes!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: MyColors.primaryColor800),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(labelText: 'Nombre'),
                              controller: _nombreController,
                            ),
                          ),
                          SizedBox(height: 12),
                          IngredienteDropDown(
                            initial: taco.tortilla,
                            label: "Tortilla",
                            ingredientList: ingredientsvm.tortillasList,
                            callback: (value) {
                              setState(() {
                                taco.tortilla = value!;
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          IngredienteDropDown(
                            initial: taco.carnes.firstOrNull,
                            label: "Carne",
                            ingredientList: ingredientsvm.carnesList,
                            callback: (value) {
                              setState(() {
                                taco.carnes.add(value!);
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          IngredienteDropDown(
                            initial: taco.picadillos.firstOrNull,
                            label: "Picadillo",
                            ingredientList: ingredientsvm.picadillosList,
                            callback: (value) {
                              setState(() {
                                taco.picadillos.add(value!);
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          IngredienteDropDown(
                            initial: taco.salsas.firstOrNull,
                            label: "Salsa",
                            ingredientList: ingredientsvm.salsasList,
                            callback: (value) {
                              setState(() {
                                taco.salsas.add(value!);
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          IngredienteDropDown(
                            initial: taco.otros.firstOrNull,
                            label: "Otros",
                            ingredientList: ingredientsvm.otrosList,
                            callback: (value) {
                              setState(() {
                                taco.otros.add(value!);
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          MyColors.ternaryColor300),
                                  onPressed: () {
                                    taco.nombre = _nombreController.text;
                                    pedidovm.ingresarTaco(
                                      taco
                                        ..baseValue = 100
                                        ..owner = OwnerModel(
                                            ownerId: MongoRealmsConfig().myId,
                                            ownerType: 'Cliente'),
                                    );
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor:
                                            MyColors.secondaryColor50,
                                        title:
                                            const Text('Agregado al Carrito'),
                                        content: const Text(
                                            'Desea continuar con el pago?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'No'),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/home/pedido');
                                            },
                                            child: const Text('Si'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Ingresar',
                                    style: TextStyle(
                                        color: MyColors.primaryColor800),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          buildervm.shareTaco(
                                            taco
                                              ..baseValue = 100
                                              ..owner = OwnerModel(
                                                  ownerId:
                                                      MongoRealmsConfig().myId,
                                                  ownerType: 'publico'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Tu taco sera revisado para publicarse.'),
                                          ));
                                        },
                                        icon: const Icon(Icons.share)),
                                    IconButton(
                                        onPressed: () {
                                          taco.nombre = _nombreController.text;
                                          buildervm.shareTaco(
                                            taco
                                              ..baseValue = 100
                                              ..owner = OwnerModel(
                                                  ownerId:
                                                      MongoRealmsConfig().myId,
                                                  ownerType: 'Privado'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Taco guardado en Tus tacos'),
                                          ));
                                        },
                                        icon: const Icon(Icons.save)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
