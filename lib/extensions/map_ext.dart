extension optional on Map {
  // TODO:Figure out how to handle optional params
  /// Recursively traverses a map and converts [int] keys to  [String]
  Map<dynamic, dynamic> deepConvertMapKeyToString(
      {bool Function(dynamic key)? keyMatch, bool? changeKey}) {
    final newMap = <dynamic, dynamic>{};
    forEach((key, value) {
      final newKey = key is int ? key.toString() : key;
      newMap[newKey] = value is Map ? value.deepConvertMapKeyToString() : value;
    });
    return newMap;
  }
  // Map<dynamic, dynamic> deepConvertMapKeyToString(
  //     {bool Function(dynamic key)? keyMatch, bool changeKey = true}) {
  //   final newMap = <dynamic, dynamic>{};
  //   forEach((key, value) {
  //     // Check if the key matches the condition for skipping recursion.
  //     final bool skipRecursion = keyMatch != null && keyMatch(key);

  //     // Determine the new key based on changeKey.
  //     //If changeKey is false, retain the original key type.
  //     final newKey = changeKey && key is int ? key.toString() : key;

  //     // Add the value to the new map, either by recursing into it or keeping it as is.
  //     newMap[newKey] = !skipRecursion && value is Map
  //         ? value.deepConvertMapKeyToString(
  //             keyMatch: keyMatch, changeKey: changeKey)
  //         : value;
  //   });
  //   return newMap;
  // }

  // Map<dynamic, dynamic> deepConvertMapKeyToString(
  //     {bool Function(dynamic key)? keyMatch, bool? changeKey}) {
  //   final newMap = <dynamic, dynamic>{};
  //   forEach((key, value) {
  //     // Check if the key matches the condition for skipping recursion.
  //     final bool skipRecursion = keyMatch != null && keyMatch(key);

  //     // Determine the new key based on changeKey.
  //     final newKey = (changeKey == null || changeKey) ? key.toString() : key;

  //     // Add the value to the new map, either by recursing into it or keeping it as is.
  //     newMap[newKey] = !skipRecursion && value is Map
  //         ? (value).deepConvertMapKeyToString(
  //             keyMatch: keyMatch, changeKey: changeKey)
  //         : value;
  //   });
  //   return newMap;
  // }

  // /// Recursively traverses a map and converts [String] keys to  [int]
  Map<dynamic, dynamic> deepConvertMapKeyToInt() {
    final newMap = <dynamic, dynamic>{};
    forEach((key, value) {
      if (key is String && int.tryParse(key) != null) {
        newMap[int.parse(key)] =
            value is Map ? value.deepConvertMapKeyToInt() : value;
      } else {
        newMap[key] = value is Map ? value.deepConvertMapKeyToInt() : value;
      }
    });
    return newMap;
  }
}
