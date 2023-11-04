import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class TacoImage extends StatelessWidget {
  const TacoImage(
      {super.key,
      this.uri =
          'https://www.cocinavital.mx/wp-content/uploads/2018/08/tacos-de-pulpo-zarandeado.jpg'});
  final String uri;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: uri,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
