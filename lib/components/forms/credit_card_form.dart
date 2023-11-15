import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tunitacos_flutter/components/textformfields/creditcard_number_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/cvv_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/exp_date_textformdield.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm(
      {super.key,
      required this.callback,
      required this.handler,
      required this.direccionController,
      required this.telefonoController});

  final Function(String) callback;
  final Future<bool> Function() handler;
  final TextEditingController direccionController;
  final TextEditingController telefonoController;
  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cvvNumberController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _cvvNumberController.text = "123";
    _cardNumberController.text = "5425233430109903";
    _expireDateController.text = "11/23";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Datos de Tarjeta',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: width - 100,
                    child: CreditCardNumberTextFormField(
                        controller: _cardNumberController,
                        callback: (value) {
                          if (value != null) {
                            if (RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$")
                                .hasMatch(value.toString())) {
                              return null;
                            }
                            if (RegExp(r"^5(?:[1-5][0-9]{0,14})?$")
                                .hasMatch(value.toString())) {
                              return null;
                            }
                          }
                          return "Numero de tarjeta invalido";
                        }),
                  ),
                  SizedBox(
                    width: width - 100,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        label: Text('Nombre Propietario'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (width - 105) / 2,
                        child: CvvTextFormField(
                          controller: _cvvNumberController,
                          callback: (value) {
                            if (value != null &&
                                RegExp(r"^[0-9]{3,4}$").hasMatch(value)) {
                              return null;
                            }
                            return "CVV Invalido";
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: (width - 105) / 2,
                        child: ExpDateTextFormField(
                          controller: _expireDateController,
                          callback: (value) {
                            if (value != null &&
                                RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$")
                                    .hasMatch(value)) {
                              return null;
                            }
                            return "Fecha Invalida";
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contacto',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: width - 100,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Debe ingresar una direccion";
                      },
                      controller: widget.direccionController,
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
                      controller: widget.telefonoController,
                      decoration: const InputDecoration(
                        label: Text('Telefono'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.ternaryColor300,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.callback("Tarjeta");
                      }
                    },
                    child: const Text('Pagar',
                        style: TextStyle(color: MyColors.primaryColor800)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
