import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/components/widgets/taco_image_widget.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/theme/colors.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/taco_builder_viewmodel.dart';

class TacoCard extends StatelessWidget {
  const TacoCard({super.key, required this.taco});
  final TacoModel taco;

  @override
  Widget build(BuildContext context) {
    final buildervm = Provider.of<TacoBuilderViewModel>(context);
    final pedidovm = Provider.of<PedidoViewModel>(context);
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            const TacoImage(),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Divider(
                thickness: 0.3,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      taco.nombre!,
                      style: GoogleFonts.poppins(
                          color: MyColors.secondaryColor700, fontSize: 24),
                    ),
                  ),
                  TextRow(title: 'Tortilla: ', content: taco.tortilla!.nombre),
                  TextRow(
                    title: 'Carnes: ',
                    content: taco.carnes.map((e) => e!.nombre).join(', '),
                  ),
                  if (taco.picadillos.isNotEmpty)
                    TextRow(
                      title: 'Picadillos: ',
                      content: taco.picadillos.map((e) => e!.nombre).join(', '),
                    ),
                  if (taco.salsas.isNotEmpty)
                    TextRow(
                      title: 'Salsas: ',
                      content: taco.salsas.map((e) => e!.nombre).join(', '),
                    ),
                  if (taco.otros.isNotEmpty)
                    TextRow(
                      title: 'Otros: ',
                      content: taco.otros.map((e) => e!.nombre).join(', '),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 4.0, 0, 12.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/create', arguments: taco);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.ternaryColor200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: MyColors.ternaryColor900)),
                    child: const Text('Editar',
                        style: TextStyle(color: MyColors.ternaryColor900)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: MyColors.secondaryColor50,
                          title: const Text('Agregado al Carrito'),
                          content: const Text('Desea continuar con el pago?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'No'),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/home/pedido');
                              },
                              child: const Text('Si'),
                            ),
                          ],
                        ),
                      );
                      pedidovm.ingresarTaco(taco);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: MyColors.primaryColor900)),
                    child: const Text('Agregar',
                        style: TextStyle(color: MyColors.primaryColor900)),
                  ),
                  const Spacer(),
                  TextRowPrice(
                      title: 'Precio: ', content: 'C\$${taco.baseValue}'),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
        child: Row(
          children: [
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w500)),
            Expanded(
              child: Text(content,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w200, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class TextRowPrice extends StatelessWidget {
  const TextRowPrice({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 0, 0),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Text(
              content,
              style: GoogleFonts.poppins(
                  fontSize: 26,
                  color: MyColors.secondaryColor900,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
