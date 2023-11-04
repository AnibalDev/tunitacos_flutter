import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/components/textformfields/creditcard_number_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/cvv_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/exp_date_textformdield.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          SizedBox(
            width: 300,
            child: FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text("Ingresar"),
            ),
          )
        ],
      ),
    );
  }
}
