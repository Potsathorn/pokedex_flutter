// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pokedex_flutter/domain/usecase/pokedex_usecase.dart';
import 'package:pokedex_flutter/domain/usecase/pokemon_usecase.dart';
import 'package:pokedex_flutter/presentation/bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/presentation/screen/pokedex.dart';
import 'package:pokedex_flutter/presentation/widget/image_network_builder.dart';
import 'package:pokedex_flutter/presentation/widget/loading.dart';
import 'package:pokedex_flutter/presentation/widget/show_message.dart';
import 'package:pokedex_flutter/presentation/widget/type_tag.dart';
import 'package:pokedex_flutter/utils/colors.dart';
import 'package:pokedex_flutter/utils/extension.dart';
import 'package:pokedex_flutter/utils/helper.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonInitial || state is LoadingState) {
          return const Loading();
        } else if (state is FailureState) {
          return ShowMessage(message: state.message);
        } else if (state is PokemonHasData) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return _buildPokemonLargeDisplay(
                  context: context,
                  state: state,
                  width: width,
                  aspectRatio: 2 / 1);
            } else if (constraints.maxWidth > 700) {
              return _buildPokemonLargeDisplay(
                  context: context,
                  state: state,
                  width: width,
                  aspectRatio: 3 / 2);
            } else if (constraints.maxWidth > 600) {
              return _buildPokemonLargeDisplay(
                  context: context,
                  state: state,
                  width: width,
                  aspectRatio: 4.2 / 3);
            } else if (constraints.maxWidth > 400) {
              return _buildPokemonSmallDisplay(
                  context: context,
                  state: state,
                  width: width,
                  aspectRatio: 2 / 2.3);
            } else {
              return _buildPokemonSmallDisplay(
                context: context,
                state: state,
                width: width,
                aspectRatio: 3 / 4.2,
              );
            }
          });
        } else {
          return const ShowMessage(message: "Something went wrong!");
        }
      },
    );
  }

  Widget _buildPokemonSmallDisplay(
      {required BuildContext context,
      required PokemonState state,
      required double width,
      required double aspectRatio}) {
    if (state is PokemonHasData) {
      final pokemon = state.pokemon;
      final image = pokemon.sprites?.other?.home?.frontDefault ?? '';
      final imageBackup = pokemon.sprites?.frontDefault ?? '';
      final id = pokemon.id!;
      final order = Helper.formatWithLeadingZeros(pokemon.id!);
      final name = pokemon.name ?? '-';
      final types = pokemon.types!
          .map(
            (e) => e.type?.name,
          )
          .toList();

      final height = Helper.decimetresToMetres(pokemon.height ?? 0);
      final weight = Helper.hectogramsToKilograms(pokemon.weight ?? 0);

      final hp =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "hp").baseStat;
      final atk =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "attack").baseStat;
      final def =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "defense").baseStat;
      final spd =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "speed").baseStat;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: (width / 1.8) / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: AppColors.textSecondary
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                              Text(
                                name.capitalize(),
                                style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              Row(
                                children: [
                                  for (var i = 0; i < types.length; i++)
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: i == types.length - 1 ? 0 : 5),
                                      child: TypeTag(
                                          text: types[i]?.capitalize() ?? ''),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _subDetailBuilder(title: 'Height', detail: height),
                            _subDetailBuilder(title: 'Weight', detail: weight),
                          ],
                        ),
                        Column(
                          children: [
                            _statusBarBuilder(title: 'HP', value: hp),
                            _statusBarBuilder(title: 'ATK', value: atk),
                            _statusBarBuilder(title: 'DEF', value: def),
                            _statusBarBuilder(title: 'SPD', value: spd),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -(width / 1.8) / 3,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      width: width / 1.8,
                      height: width / 1.8,
                      child: ImageNetworkBuilder(
                        mainUrl: image,
                        backupUrl: imageBackup,
                      ),
                    ),
                  ),
                  if (state.previous != null)
                    Positioned(
                        top: 50,
                        left: 35,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<PokemonBloc>(context).add(
                                GetByIDEvent(
                                    pokemonParam: PokemonParam(id: id - 1)));
                          },
                          child: _circularIconBuilder(
                              icon: Icons.arrow_back_ios_rounded),
                        )),
                  if (state.next != null)
                    Positioned(
                        top: 50,
                        right: 35,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<PokemonBloc>(context).add(
                                GetByIDEvent(
                                    pokemonParam: PokemonParam(id: id + 1)));
                          },
                          child: _circularIconBuilder(
                              icon: Icons.arrow_forward_ios_rounded),
                        )),
                  Positioned(
                    bottom: 5,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<PokemonBloc>(context).add(GetAllEvent(
                            pokedexParam: PokedexParam(limit: 20, offset: 0)));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const PokedexScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: AppColors.background,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Pokedex',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const ShowMessage(message: "Something went wrong!");
    }
  }

  Widget _buildPokemonLargeDisplay(
      {required BuildContext context,
      required PokemonState state,
      required double width,
      required double aspectRatio}) {
    if (state is PokemonHasData) {
      final pokemon = state.pokemon;
      final image = pokemon.sprites?.other?.home?.frontDefault ?? '';
      final imageBackup = pokemon.sprites?.frontDefault ?? '';
      final id = pokemon.id!;
      final order = Helper.formatWithLeadingZeros(pokemon.id!);
      final name = pokemon.name ?? '-';
      final types = pokemon.types!
          .map(
            (e) => e.type?.name,
          )
          .toList();

      final height = Helper.decimetresToMetres(pokemon.height ?? 0);
      final weight = Helper.hectogramsToKilograms(pokemon.weight ?? 0);

      final hp =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "hp").baseStat;
      final atk =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "attack").baseStat;
      final def =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "defense").baseStat;
      final spd =
          pokemon.stats!.firstWhere((e) => e.stat!.name == "speed").baseStat;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.5 / 1.8,
                                  height: width * 0.5 / 1.8,
                                  child: ImageNetworkBuilder(
                                    mainUrl: image,
                                    backupUrl: imageBackup,
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order,
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          color: AppColors.textSecondary
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      name.capitalize(),
                                      style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Row(
                                      children: [
                                        for (var i = 0; i < types.length; i++)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: i == types.length - 1
                                                    ? 0
                                                    : 5),
                                            child: TypeTag(
                                                text: types[i]?.capitalize() ??
                                                    ''),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Row(
                                    children: [
                                      _subDetailBuilder(
                                          title: 'Height', detail: height),
                                      _subDetailBuilder(
                                          title: 'Weight', detail: weight),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    _statusBarBuilder(title: 'HP', value: hp),
                                    _statusBarBuilder(title: 'ATK', value: atk),
                                    _statusBarBuilder(title: 'DEF', value: def),
                                    _statusBarBuilder(title: 'SPD', value: spd),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  if (state.previous != null)
                    Positioned(
                        top: 50,
                        bottom: 50,
                        left: 35,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<PokemonBloc>(context).add(
                                GetByIDEvent(
                                    pokemonParam: PokemonParam(id: id - 1)));
                          },
                          child: _circularIconBuilder(
                              icon: Icons.arrow_back_ios_rounded),
                        )),
                  if (state.next != null)
                    Positioned(
                        top: 50,
                        bottom: 50,
                        right: 35,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<PokemonBloc>(context).add(
                                GetByIDEvent(
                                    pokemonParam: PokemonParam(id: id + 1)));
                          },
                          child: _circularIconBuilder(
                              icon: Icons.arrow_forward_ios_rounded),
                        )),
                  Positioned(
                    bottom: 5,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<PokemonBloc>(context).add(GetAllEvent(
                            pokedexParam: PokedexParam(limit: 20, offset: 0)));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const PokedexScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: AppColors.background,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Pokedex',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const ShowMessage(message: "Something went wrong!");
    }
  }

  Widget _subDetailBuilder({required String title, required String detail}) =>
      Expanded(
          child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          Text(
            detail,
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          )
        ],
      ));

  Widget _statusBarBuilder(
          {required String title, int? value = 0, Color? color}) =>
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Expanded(
            flex: 8,
            child: LinearProgressIndicator(
              minHeight: 8,
              value: (value! / 300),
              backgroundColor: AppColors.textSecondary,
              valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? AppColors.primaryColor),
            ),
          )
        ],
      );

  Widget _circularIconBuilder({required IconData icon}) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.7),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.background,
          size: 30.0,
        ),
      ),
    );
  }
}
