import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/screens/home_screen.dart';
import 'package:tunitacos_flutter/screens/login_screen.dart';
import 'package:tunitacos_flutter/theme/theme_data.dart';
import 'package:tunitacos_flutter/view/pay_method.dart';
import 'package:tunitacos_flutter/view/taco_builder.dart';
import 'package:tunitacos_flutter/viewmodels/ingredient_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/taco_builder_viewmodel.dart';
import 'package:tunitacos_flutter/viewmodels/tacos_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IngredientViewModel()),
        ChangeNotifierProvider(create: (context) => TacoViewModel()),
        ChangeNotifierProvider(create: (context) => TacoBuilderViewModel()),
        ChangeNotifierProvider(create: (context) => PedidoViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tunitacos',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          bottomNavigationBarTheme: bottomNavigationBarTheme,
          appBarTheme: appBarTheme,
          cardTheme: cardTheme,
          tabBarTheme: tabBarTheme,
          colorScheme: colorScheme,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/home/pedido': (context) => HomeScreen.withIndex(ind: 1),
          '/pay': (context) => const PayMethodView(),
          '/create': (context) => const TacoBuilderPlusUltraView()
        },
      ),
    );
  }
}
