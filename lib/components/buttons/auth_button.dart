import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
          onPressed: () async {
            final LoginResult result = await FacebookAuth.instance.login(
                permissions: [
                  'email'
                ]); // by default we request the email and the public profile
// or FacebookAuth.i.login()
            if (result.status == LoginStatus.success) {
              // you are logged
              final AccessToken accessToken = result.accessToken!;
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              print(result.status);
              print(result.message);
            }
          },
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
