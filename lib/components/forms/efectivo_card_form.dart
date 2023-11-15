import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class EfectivoCardForm extends StatefulWidget {
  const EfectivoCardForm(
      {super.key,
      required this.handler,
      required this.callback,
      required this.direccionController,
      required this.telefonoController,
      required this.billeteController});

  final Function(String) callback;
  final Future<bool> Function() handler;
  final TextEditingController direccionController;
  final TextEditingController telefonoController;
  final TextEditingController billeteController;
  @override
  State<EfectivoCardForm> createState() => _EfectivoCardFormState();
}

class _EfectivoCardFormState extends State<EfectivoCardForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    'Contacto',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: width - 100,
                    child: TextFormField(
                      controller: widget.direccionController,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Debe ingresar una direccion";
                      },
                      decoration: InputDecoration(
                        label: const Text('Direccion'),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.location_on),
                            onPressed: () async {
                              widget.handler;
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              widget.direccionController.text =
                                  "${position.latitude} + ${position.longitude}";
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width - 100,
                    child: TextFormField(
                      controller: widget.telefonoController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length >= 8) {
                          RegExp _numeric = RegExp(r'^-?[0-9]+$');

                          if (_numeric.hasMatch(value)) {
                            return null;
                          }
                          return "Formato no valido";
                        }
                        return "Debe ingresar un telefono de referencia";
                      },
                      decoration: const InputDecoration(
                        label: Text('Telefono'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.ternaryColor300,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.callback("Efectivo");
                      }
                    },
                    child: const Text('Pagar',
                        style: TextStyle(color: MyColors.primaryColor800)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
