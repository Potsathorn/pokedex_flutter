// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pokedex_flutter/injector.dart' as di;
import 'package:pokedex_flutter/presentation/bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex_flutter/presentation/screen/pokedex.dart';
import 'package:pokedex_flutter/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<PokemonBloc>(),
      child: MaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const PokedexScreen(),
      ),
    );
  }
}
