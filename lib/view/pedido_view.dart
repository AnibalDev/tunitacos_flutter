import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';

import '../theme/colors.dart';

class PedidoView extends StatefulWidget {
  const PedidoView({super.key});

  @override
  State<PedidoView> createState() => _PedidoViewState();
}

class _PedidoViewState extends State<PedidoView> {
  late PedidoViewModel provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PedidoViewModel>(context);
    provider.fetchStateData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tu Pedido',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: Colors.white),
        ),
      ),
      body: provider.state == "Espera"
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pedido en espera',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : provider.state == "Atendiendo"
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pedido atendiendo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
              : provider.pedidoModel.tacosList.isEmpty
                  ? Center(
                      child: Text(
                      'Pedido Vacio',
                      style: GoogleFonts.poppins(
                          fontSize: 30, color: MyColors.primaryColor800),
                    ))
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: provider.pedidoModel.tacosList
                                        .where(
                                            (element) => element.cantidad > 0)
                                        .map<Widget>(
                                      (taco) {
                                        return PedidoListItem(tm: taco);
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.ternaryColor300,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/pay');
                                  },
                                  child: const Text('Pagar',
                                      style: TextStyle(
                                          color: MyColors.primaryColor800)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}

class PedidoListItem extends StatefulWidget {
  const PedidoListItem({super.key, required this.tm});
  final TacoModel tm;

  @override
  State<PedidoListItem> createState() => _PedidoListItemState();
}

class _PedidoListItemState extends State<PedidoListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Stack(
          children: [
            Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.disabled_by_default_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    widget.tm.cantidad = 0;
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Nombre: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.tm.nombre ?? "Taco Default"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Cantidad: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.tm.cantidad.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Total: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('C\$' +
                              (widget.tm.precio * widget.tm.cantidad)
                                  .toString()),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.tm.cantidad = widget.tm.cantidad > 1
                                ? widget.tm.cantidad - 1
                                : widget.tm.cantidad;
                          });
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(widget.tm.cantidad.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.tm.cantidad++;
                          });
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
