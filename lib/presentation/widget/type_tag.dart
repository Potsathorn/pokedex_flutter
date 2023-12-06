// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pokedex_flutter/utils/colors.dart';

class TypeTag extends StatelessWidget {
  final String text;

  const TypeTag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      decoration: BoxDecoration(
        color: PokemonTypeColors.get(text),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
