import 'package:flutter/material.dart';
import 'package:tunitacos_flutter/components/textformfields/email_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/password_textformfield.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _actualEmailController = TextEditingController();
  final _actualPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Perfil',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(30),
                width: 400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'UserId: ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(MongoRealmsConfig().myId),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Correo: ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(MongoRealmsConfig().myEmail),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Cambiar contraseña',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    PasswordTexFormField(
                        controller: _actualPasswordController,
                        text: "Actual",
                        callback: (x) {}),
                    PasswordTexFormField(
                      controller: _newPasswordController,
                      callback: (x) {},
                      text: "Nueva",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.ternaryColor300,
                        ),
                        onPressed: () {
                          MongoRealmsConfig().resetPasswordFunction(
                              _newPasswordController.text,
                              _actualPasswordController.text);
                        },
                        child: const Text('Confirmar',
                            style: TextStyle(color: MyColors.primaryColor800)),
                      ),
                    ),
                    Text(
                      'Sesión',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.ternaryColor300,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: const Text('Cerrar sesion',
                            style: TextStyle(color: MyColors.primaryColor800)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
