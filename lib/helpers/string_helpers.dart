import 'package:usda_db_creation/global_const.dart';

/// Removes all non-alpha except dashes and parentheses,
/// and numbers followed by a % See notes at bottom a file
String removeUnwantedChars(final String word) {
  final stringSanitizerRegEx = RegExp(r"[^\w()%\-]|(\d+%)");

  return word.replaceAllMapped(
      stringSanitizerRegEx, (final match) => match.group(1) ?? '');
}

/// Separates words with dashes or parentheses.
/// Returns a list of a word(s), list may be empty and may contain empty strings.
List<String> stripDashedAndParenthesisWord(final String word) {
  if (word.contains('-')) return word.split('-');
  if (word.startsWith('(') && word.endsWith(')')) {
    final trimmed = word.substring(1, word.length - 1);
    return [trimmed];
  }
  if (word.contains('(')) return word.split('(');
  if (word.contains(')')) return word.split(')');

  return word.isNotEmpty ? [word] : [];
}

/// Cleans up a sentence, removing all unwanted characters

/// Returns a set of lowercased words to be indexed.

Set<String> getWordsToIndex(final String sentence) {
  final List<List<String>> words = [];

  for (final word in sentence.split(' ')) {
    final String charDash = removeUnwantedChars(word).toLowerCase();
    final List<String> splitWords = stripDashedAndParenthesisWord(charDash);

    if (splitWords.isNotEmpty) {
      words.add(splitWords);
    }
  }
  final wordsSet = words.expand((final list) => list).toSet();
  wordsSet.remove('');
  return wordsSet;
}

bool isStopWord(final word) {
  return stopWords.contains(word);
}
