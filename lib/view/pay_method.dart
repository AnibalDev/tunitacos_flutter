import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/components/forms/credit_card_form.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';

class PayMethodView extends StatefulWidget {
  const PayMethodView({super.key});

  @override
  State<PayMethodView> createState() => _PayMethodViewState();
}

class _PayMethodViewState extends State<PayMethodView> {
  var direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PedidoViewModel vm = Provider.of<PedidoViewModel>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pago',
          ),
          automaticallyImplyLeading: false,
          bottom: const TabBar(tabs: <Widget>[
            Tab(
              text: 'Tarjeta',
              icon: Icon(Icons.credit_card),
            ),
            Tab(
              text: 'Efectivo',
              icon: Icon(Icons.payments),
            ),
            Tab(
              text: 'Transferencia',
              icon: Icon(Icons.account_balance),
            ),
          ]),
        ),
        body: TabBarView(children: [
          const CreditCardForm(),
          Column(
            children: [
              const Text('Direccion'),
              TextField(
                controller: direccionController,
              ),
              ElevatedButton(
                  onPressed: () {
                    vm.pedidoModel.direccion = direccionController.text;
                    vm.pedidoModel.payMethod = "Efectivo";
                    vm.pushNewPedido();
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Ingresar Pedido'))
            ],
          ),
          Container(),
        ]),
      ),
    );
  }
}
