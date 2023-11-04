import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunitacos_flutter/theme/colors.dart';
import 'package:tunitacos_flutter/view/home.dart';
import 'package:tunitacos_flutter/view/pedido_view.dart';
import 'package:tunitacos_flutter/view/profile_view.dart';
import 'package:tunitacos_flutter/viewmodels/pedido_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen.withIndex({required int ind, super.key}) {
    index = ind;
  }
  HomeScreen({super.key});

  int index = 0;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  late int currentViewIndex = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.4, color: MyColors.primaryColor700),
          ),
        ),
        child: BottomNavigationBar(
          onTap: (index) => setState(
            () => currentViewIndex = index,
          ),
          //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          currentIndex: currentViewIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: Provider.of<PedidoViewModel>(context).hasData,
                  label: Text(
                      Provider.of<PedidoViewModel>(context).lenght.toString()),
                  child: const Icon(Icons.wallet),
                ),
                label: 'Pedido'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
      body: const <Widget>[
        HomeView(),
        PedidoView(),
        ProfileView()
      ][currentViewIndex],
    );
  }
}
