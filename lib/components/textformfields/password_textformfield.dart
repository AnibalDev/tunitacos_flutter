import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class PasswordTexFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? callback;
  final String text;

  const PasswordTexFormField(
      {super.key,
      required this.controller,
      required this.callback,
      this.text = "Contraseña"});

  @override
  State<PasswordTexFormField> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<PasswordTexFormField> {
  bool _isObscured = true;

  Icon _suffixIcon = Icon(Icons.visibility);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        obscureText: _isObscured,
        validator: widget.callback,
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(widget.text),
          prefixIcon: const Icon(Icons.vpn_key),
          iconColor: Colors.white,
          prefixIconColor: MyColors.ternaryColor300,
          suffixIcon: IconButton(
              icon: _suffixIcon,
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              }),
        ),
      ),
    );
  }
}
