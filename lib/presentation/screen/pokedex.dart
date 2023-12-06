// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pokedex_flutter/config/base_url.dart';
import 'package:pokedex_flutter/data/model/pokedex_model.dart';
import 'package:pokedex_flutter/domain/usecase/pokedex_usecase.dart';
import 'package:pokedex_flutter/domain/usecase/pokemon_usecase.dart';
import 'package:pokedex_flutter/presentation/bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/presentation/screen/pokemon.dart';
import 'package:pokedex_flutter/presentation/widget/image_network_builder.dart';
import 'package:pokedex_flutter/presentation/widget/loading.dart';
import 'package:pokedex_flutter/presentation/widget/show_message.dart';
import 'package:pokedex_flutter/utils/colors.dart';
import 'package:pokedex_flutter/utils/extension.dart';
import 'package:pokedex_flutter/utils/helper.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final _scrollController = ScrollController();
  bool _isLoadMore = false;
  List<ShortDetail> _items = [];
  String? _next;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context)
        .add(GetAllEvent(pokedexParam: PokedexParam(limit: 20, offset: 0)));
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 100.0;
      if (maxScroll - currentScroll <= delta) {
        _isLoadMore = true;
      } else {
        _isLoadMore = false;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonInitial || state is LoadingState) {
          return const Loading();
        } else if (state is FailureState) {
          return ShowMessage(message: state.message);
        } else if (state is PokedexHasData || state is LoadMoreState) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return _buildPokedex(state: state, crossAxisCount: 5);
            } else if (constraints.maxWidth > 700) {
              return _buildPokedex(state: state, crossAxisCount: 4);
            } else if (constraints.maxWidth > 600) {
              return _buildPokedex(state: state, crossAxisCount: 3);
            } else {
              return _buildPokedex(state: state, crossAxisCount: 2);
            }
          });
        } else {
          return const ShowMessage(message: "Something went wrong!");
        }
      },
    );
  }

  Widget _buildPokedex(
      {required PokemonState state, required int crossAxisCount}) {
    if (state is PokedexHasData) {
      _items = state.pokedex.results ?? [];
      _next = state.pokedex.next;
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Pokedex',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              controller: _scrollController,
              crossAxisCount: crossAxisCount,
              childAspectRatio: (1 / 1),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              physics: const BouncingScrollPhysics(),
              children: _items.map(
                (data) {
                  final pokemonNumber = Helper.extractPokemonNumber(data.url!);
                  return GestureDetector(
                      onTap: () {
                        BlocProvider.of<PokemonBloc>(context).add(GetByIDEvent(
                            pokemonParam: PokemonParam(id: pokemonNumber)));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const PokemonScreen()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColors.backgroundSecondary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: ImageNetworkBuilder(
                                  mainUrl:
                                      '${BaseUrlConfig().mainImageUrl}/$pokemonNumber.png',
                                  backupUrl:
                                      '${BaseUrlConfig().backupImageUrl}/$pokemonNumber.png',
                                )),
                            Flexible(
                              child: Text(
                                  Helper.formatWithLeadingZeros(pokemonNumber),
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.primaryColor),
                                  textAlign: TextAlign.center),
                            ),
                            Flexible(
                              child: Text(data.name!.capitalize(),
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppColors.textPrimary),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ));
                },
              ).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: (state is LoadMoreState)
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              ],
            )
          : _isLoadMore && _next != null
              ? InkWell(
                  onTap: () {
                    _isLoadMore = false;
                    BlocProvider.of<PokemonBloc>(context).add(LoadMoreEvent());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Icon(
                            Icons.refresh_rounded,
                            size: 18,
                            color: AppColors.background,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Load More',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.background,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
    );
  }
}
