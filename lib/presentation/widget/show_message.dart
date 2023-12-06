// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pokedex_flutter/utils/colors.dart';

class ShowMessage extends StatelessWidget {
  final String message;
  const ShowMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
