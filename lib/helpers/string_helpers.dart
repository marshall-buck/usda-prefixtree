/// Regex to find non-chars
final stringSanitizerRegEx = RegExp(r'[\s\W\d]');

const stopWords = [
  'a',
  'an',
  'and',
  'are',
  'as',
  'at',
  'be',
  'but',
  'by',
  'for',
  'if',
  'in',
  'into',
  'is',
  'it',
  'no',
  'not',
  'of',
  'on',
  'or',
  'such',
  'that',
  'the',
  'their',
  'then',
  'there',
  'these',
  'they',
  'this',
  'to',
  'was',
  'will',
  'with'
];

/// Given a [word], convert to lowercase and strip it of punctuation. Return a
/// sanitized string [trimmed] its possible to return an empty string.
String stripUnwantedCharacters(String word) {
  final String trimmed = word.trim().toLowerCase();

  if (trimmed.contains(stringSanitizerRegEx)) {
    return trimmed.replaceAll(stringSanitizerRegEx, '');
  }

  return trimmed;
}

/// Givin a Food description [str], return a list [sanitizedList] of sanitized strings for
/// the autocomplete search or [] if [str] is empty.
/// Check if [sanitized] is in the stop word list or is an empty string.
List<String> stripUnwantedWords(String str) {
  if (str == '') return [];
  final List<String> list = str.split(' ');
  final List<String> sanitizedList = [];

  for (var word in list) {
    final sanitized = stripUnwantedCharacters(word);
    if (!stopWords.contains(sanitized) &&
        sanitized.isNotEmpty &&
        sanitized.length > 2) {
      sanitizedList.add(sanitized);
    }
  }

  return sanitizedList;
}
