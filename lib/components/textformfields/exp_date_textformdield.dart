import 'package:flutter/material.dart';

class ExpDateTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? callback;

  const ExpDateTextFormField(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        validator: callback,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Exp Date'),
          prefixIcon: const Icon(Icons.event),
          prefixIconColor: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
