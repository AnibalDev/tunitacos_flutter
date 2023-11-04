import 'package:flutter/material.dart';

class CreditCardNumberTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? callback;

  const CreditCardNumberTextFormField(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: callback,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Numero de Tarjeta'),
          prefixIcon: const Icon(Icons.credit_card),
          prefixIconColor: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
