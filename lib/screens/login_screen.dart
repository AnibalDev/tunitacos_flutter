import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/components/buttons/auth_button.dart';
import 'package:tunitacos_flutter/components/forms/login_form.dart';
import 'package:tunitacos_flutter/components/forms/new_account_form.dart';
import 'package:tunitacos_flutter/theme/colors.dart';
import 'package:tunitacos_flutter/viewmodels/ingredient_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/taco_builder_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/tacos_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomeViewState();
}

class _HomeViewState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget form = const LoginForm();
  var _mainText = "Ingreso";
  var _secondaryText = "No tienes una cuenta?";
  var _toggleButtonText = "Registrate ahora";
  void toggle() {
    if (form is LoginForm) {
      form = NewAccountForm();
      _mainText = "Crear cuenta";
      _secondaryText = "Ya tienes una cuenta?";
      _toggleButtonText = "Inicia Sesion";
    } else {
      form = LoginForm();
      _mainText = "Ingreso";
      _secondaryText = "No tienes una cuenta?";
      _toggleButtonText = "Registrate ahora";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<IngredientViewModel>(context);
    Provider.of<TacoViewModel>(context);
    Provider.of<TacoBuilderViewModel>(context);
    double width = MediaQuery.of(context).size.width;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width / 1.5,
              child: Center(
                child: Image(
                    image: AssetImage('assets/images/tunitacos-logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(_mainText,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.apply(color: MyColors.primaryColor800)),
                      form,
                     const  SizedBox(height: 10),
                      const Text('O continua con'),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthButton(
                              assetPath:
                                  'assets/socialmedia-icons/googleicon2.png',
                              text: 'Google'),
                          SizedBox(width: 20),
                          AuthButton(
                              assetPath:
                                  'assets/socialmedia-icons/facebookicon2.jpg',
                              text: 'Facebook'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_secondaryText),
                          TextButton(
                              onPressed: () {
                                toggle();
                              },
                              child: Text(_toggleButtonText))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
