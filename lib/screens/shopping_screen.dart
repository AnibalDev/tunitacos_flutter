import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/components/forms/credit_card_form.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar pago'),
      ),
      body: const SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              CreditCardForm(),
            ],
          ),
        )),
      ),
    );
  }
}
