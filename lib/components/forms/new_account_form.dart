import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:tunitacos_flutter/components/textformfields/email_textformfield.dart';
import 'package:tunitacos_flutter/components/textformfields/password_textformfield.dart';
import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';
import 'package:tunitacos_flutter/theme/colors.dart';

class NewAccountForm extends StatefulWidget {
  const NewAccountForm({super.key});

  @override
  State<NewAccountForm> createState() => _LoginForm();
}

class _LoginForm extends State<NewAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditorControler = TextEditingController();
  final _passwordTextEditorControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 300,
        child: Column(
          children: [
            EmailTextFormField(
              controller: _emailTextEditorControler,
              callback: (value) {
                if (value != null && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Correo ingresado no valido";
                }
                return null;
              },
            ),
            PasswordTexFormField(
              controller: _passwordTextEditorControler,
              callback: (value) => (value != null && value.length < 8)
                  ? "La contraseña debe contener mas de 8 digitos"
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: FilledButton(
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.primaryColor900,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await MongoRealmsConfig().createAccount(
                        _emailTextEditorControler.text,
                        _passwordTextEditorControler.text);
                    final emailPwCredentials = Credentials.emailPassword(
                        _emailTextEditorControler.text,
                        _passwordTextEditorControler.text);
                    MongoRealmsConfig().login(
                      emailPwCredentials,
                      passwordHash: _passwordTextEditorControler.text.hashCode,
                      onLogin: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      onError: () {},
                    );
                  }
                },
                child: const Text("Registrate"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
