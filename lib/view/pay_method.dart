import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/components/forms/credit_card_form.dart';
import 'package:tunitacos_flutter/components/forms/efectivo_card_form.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/models/owner.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';

class PayMethodView extends StatefulWidget {
  const PayMethodView({super.key});

  @override
  State<PayMethodView> createState() => _PayMethodViewState();
}

class _PayMethodViewState extends State<PayMethodView> {
  var direccionController = TextEditingController();
  var telefonoController = TextEditingController();
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    PedidoViewModel vm = Provider.of<PedidoViewModel>(context);
    callback(String tipo) {
      vm.pedidoModel.direccion = direccionController.text;
      vm.pedidoModel.payMethod = tipo;
      vm.pedidoModel.telefono = telefonoController.text;
      vm.pedidoModel.cliente =
          OwnerModel(ownerId: MongoRealmsConfig().myId, ownerType: "Cliente");
      vm.pushNewPedido();
      Navigator.pushReplacementNamed(context, '/home');
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pago',
          ),
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
          CreditCardForm(
              handler: _handleLocationPermission,
              callback: callback,
              direccionController: direccionController,
              telefonoController: telefonoController),
          EfectivoCardForm(
              handler: _handleLocationPermission,
              callback: callback,
              direccionController: direccionController,
              telefonoController: telefonoController),
          Container(),
        ]),
      ),
    );
  }
}
