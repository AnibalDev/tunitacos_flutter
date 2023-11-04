import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.assetPath, required this.text});

  final String assetPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              side: BorderSide(color: MyColors.primaryColor700),
              backgroundColor: MyColors.primaryColor100),
          onPressed: () {},
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  assetPath,
                  width: 20,
                  height: 20,
                ),
              ),
              Text(
                ' $text',
                style: TextStyle(color: MyColors.primaryColor700),
              )
            ],
          )),
    );
  }
}
