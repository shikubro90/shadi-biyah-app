class HeightConverter {
  static String feetAndInchesToCentimeters(String height) {
    List<String> parts = height.split(RegExp(r'\D+'));
    int feet = int.parse(parts[0]);
    int inches = int.parse(parts[1]);

    double centimeters = feet * 30.48 + inches * 2.54;

    return centimeters.toStringAsFixed(1);
  }

  static String centimetersToFeetAndInches(String centimeters) {
    double cm = double.parse(centimeters);

    int feet = (cm / 30.48).floor();
    int inches = ((cm % 30.48) / 2.54).round();

    return '${feet}ft ${inches}in';
  }

  static Map<String, String> splitHeight(String height) {
    List<String> parts = height.split(RegExp(r'\D+'));
    String feet = parts[0].trim();
    String inches = parts[1].trim();

    return {'feet': "${feet}ft", 'inches': "${inches}in"};
  }
}
