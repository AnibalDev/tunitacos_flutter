import 'package:flutter/material.dart';

class CvvTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? callback;

  const CvvTextFormField(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: callback,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('CVV'),
          prefixIcon: const Icon(Icons.pin),
          prefixIconColor: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
