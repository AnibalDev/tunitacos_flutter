import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? callback;

  const EmailTextFormField(
      {super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: callback,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Email'),
          prefixIcon: const Icon(Icons.email),
          prefixIconColor: MyColors.ternaryColor300,
        ),
      ),
    );
  }
}
