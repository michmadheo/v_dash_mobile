class ObdUtil {
  ObdUtil._();

  static num? translate(String response) {
    final parts = response.trim().split(RegExp(r'\s+'));

    if (parts.length < 3) return null;
    if (parts[0] != '41') return null;

    final pid = parts[1].toUpperCase();

    switch (pid) {
      case '0C':
        return _rpm(parts);

      case '0D':
        return _speed(parts);

      case '05':
        return _coolant(parts);

      case '04':
        return _engineLoad(parts);

      case '11':
        return _throttle(parts);

      case '42':
        return _voltage(parts);

      default:
        return null;
    }
  }

  static int _speed(List<String> parts) {
    return int.parse(parts[2], radix: 16);
  }

  static double _rpm(List<String> parts) {
    final a = int.parse(parts[2], radix: 16);
    final b = int.parse(parts[3], radix: 16);

    return ((a * 256) + b) / 4;
  }

  static int _coolant(List<String> parts) {
    return int.parse(parts[2], radix: 16) - 40;
  }

  static double _engineLoad(List<String> parts) {
    final a = int.parse(parts[2], radix: 16);

    return a * 100 / 255;
  }

  static double _throttle(List<String> parts) {
    final a = int.parse(parts[2], radix: 16);

    return a * 100 / 255;
  }

  static double _voltage(List<String> parts) {
    final a = int.parse(parts[2], radix: 16);
    final b = int.parse(parts[3], radix: 16);

    return ((a * 256) + b) / 1000;
  }
}