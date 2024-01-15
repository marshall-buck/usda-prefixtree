extension MapExtensions on Map {
  /// Recursively traverses a map and converts [int] keys to  [String]
  Map<String, dynamic> convertMapKeyToString() {
    final newMap = <String, dynamic>{};
    forEach((key, value) {
      final newKey = key is int ? key.toString() : key;
      newMap[newKey] = value is Map ? value.convertMapKeyToString() : value;
    });
    return newMap;
  }

  // /// Recursively traverses a map and converts [String] keys to  [int]
  Map<dynamic, dynamic> convertMapKeyToInt() {
    final newMap = <dynamic, dynamic>{};
    forEach((key, value) {
      if (key is String && int.tryParse(key) != null) {
        newMap[int.parse(key)] =
            value is Map ? value.convertMapKeyToInt() : value;
      } else {
        newMap[key] = value is Map ? value.convertMapKeyToInt() : value;
      }
    });
    return newMap;
  }
}
