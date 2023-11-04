import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:tunitacos_flutter/components/textformfields/email_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/password_textformfield.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditorControler = TextEditingController();
  final _passwordTextEditorControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _emailTextEditorControler.text = "anibal@anibal.com";
    _passwordTextEditorControler.text = "12345678";
    return Form(
      key: _formKey,
      child: SizedBox(
        width: width - 100,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            EmailTextFormField(
              controller: _emailTextEditorControler,
              callback: (value) =>
                  (value != null && !RegExp(r'\S+@\S+\.\S+').hasMatch(value))
                      ? "Correo ingresado no valido"
                      : null,
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTexFormField(
              controller: _passwordTextEditorControler,
              callback: (value) => (value != null && value.length < 8)
                  ? "La contraseña debe contener mas de 8 digitos"
                  : null,
            ),
            Align(
              child: TextButton(
                  onPressed: () {
                    MongoRealmsConfig()
                        .resetPasswordEmail(_emailTextEditorControler.text);
                  },
                  child: Text(
                    'Recuperar contraseña',
                    style: TextStyle(color: MyColors.primaryColor800),
                  )),
              alignment: Alignment.centerRight,
            ),
            const SizedBox(
              height: 0,
            ),
            SizedBox(
              width: 300,
              child: FilledButton(
                style: FilledButton.styleFrom(elevation: 5.0),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final emailPwCredentials = Credentials.emailPassword(
                        _emailTextEditorControler.text,
                        _passwordTextEditorControler.text);
                    MongoRealmsConfig().login(
                      emailPwCredentials,
                      passwordHash:
                          _passwordTextEditorControler.text.toString().hashCode,
                      goToHome: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      snackBar: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Credenciales invalidas'),
                        ));
                      },
                    );
                  }
                },
                child: const Text("Ingresar Sesión"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
