import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:tunitacos_flutter/components/widgets/taco_card.dart';
import 'package:tunitacos_flutter/models/taco.dart';
import 'package:tunitacos_flutter/theme/colors.dart';
import 'package:tunitacos_flutter/viewmodels/tacos_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TacoViewModel provider;
  Future<List<TacoModel>> fetchCarta() async {
    await provider.fetchTacosData();
    log('La carta fetcheado');
    return provider.tacosList;
  }

  late final Future<List<TacoModel>> future = fetchCarta();
  final _cartaPageControler = PageController();
  final _privadoPageControler = PageController();
  final _publicoPageControler = PageController();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TacoViewModel>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/create', arguments: TacoModel.newTaco());
          },
          backgroundColor: MyColors.ternaryColor300,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(
            'Catalogo',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .apply(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'La carta'),
              Tab(text: 'Mis Tacos'),
              Tab(text: 'Publicos'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: FutureBuilder(
                        future: future,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TacoModel>> snap) {
                          if (provider.catalogoCarta.isEmpty) {
                            return const LoadingIndicator(
                              indicatorType: Indicator.ballClipRotatePulse,
                              colors: [
                                MyColors.secondaryColor500,
                                MyColors.ternaryColor500
                              ],
                            );
                          } else {
                            return RefreshIndicator(
                              onRefresh: () => provider.fetchTacosData(),
                              child: StackedCardCarousel(
                                spaceBetweenItems: 400,
                                pageController: _cartaPageControler,
                                initialOffset: 100,
                                items: provider.catalogoCarta
                                    .map((tacoModel) =>
                                        TacoCard(taco: tacoModel))
                                    .toList(),
                              ),
                            );
                          }
                        }),
                  ),
                  Center(
                    child: FutureBuilder(
                        future: future,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (provider.catalogoPrivado.isEmpty) {
                            return const LoadingIndicator(
                              indicatorType: Indicator.ballClipRotatePulse,
                              colors: [
                                MyColors.secondaryColor500,
                                MyColors.ternaryColor500
                              ],
                            );
                          } else {
                            return RefreshIndicator(
                              onRefresh: () => provider.fetchTacosData(),
                              child: StackedCardCarousel(
                                spaceBetweenItems: 350,
                                initialOffset: 100,
                                pageController: _privadoPageControler,
                                items: provider.catalogoPrivado
                                    .map((tacoModel) =>
                                        TacoCard(taco: tacoModel))
                                    .toList(),
                              ),
                            );
                          }
                        }),
                  ),
                  Center(
                    child: FutureBuilder(
                      future: future,
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (provider.catalogoPublico.isEmpty) {
                          return const LoadingIndicator(
                            indicatorType: Indicator.ballClipRotatePulse,
                            colors: [
                              MyColors.secondaryColor500,
                              MyColors.ternaryColor500
                            ],
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () => provider.fetchTacosData(),
                            child: StackedCardCarousel(
                              spaceBetweenItems: 350,
                              initialOffset: 100,
                              pageController: _publicoPageControler,
                              items: provider.catalogoPublico
                                  .map((tacoModel) => TacoCard(taco: tacoModel))
                                  .toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
