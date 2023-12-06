class Helper {
  static String formatWithLeadingZeros(int number) {
    int desiredLength = 4;
    String numberString = number.toString();
    int leadingZerosCount = desiredLength - numberString.length;
    String formattedString = '#${'0' * leadingZerosCount}$numberString';

    return formattedString;
  }

  static int extractPokemonNumber(String url) {
    RegExp regex = RegExp(r'\/(\d+)\/$');
    Match? match = regex.firstMatch(url);
    return match != null ? int.parse(match.group(1)!) : -1;
  }

  static int extractOffsetFromUrl(String url) {
    RegExp regex = RegExp(r'offset=(\d+)');
    Match? match = regex.firstMatch(url);

    return match != null ? int.parse(match.group(1)!) : -1;
  }

  static String decimetresToMetres(int decimetres) {
    double metres = decimetres / 10;
    return "${metres.toStringAsFixed(1)} M";
  }

  static String hectogramsToKilograms(int hectograms) {
    double kilograms = hectograms / 10;
    return "${kilograms.toStringAsFixed(1)} KG";
  }
}
