// Flutter imports:
import 'package:flutter/material.dart';

class ImageNetworkBuilder extends StatelessWidget {
  final String mainUrl;
  final String backupUrl;

  const ImageNetworkBuilder(
      {super.key, required this.mainUrl, required this.backupUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      mainUrl,
      width: double.infinity,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(backupUrl,
            width: double.infinity,
            fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.question_mark_rounded,
          );
        });
      },
    );
  }
}
