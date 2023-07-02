import 'package:usda_db_creation/helpers/stop_words.dart';

/// Regex to find non-chars,and spaces,  EXCEPT for a dashes
final stringSanitizerRegEx = RegExp(r'[^a-zA-Z\-]');

/// Keeps only chars and dashes in a string.
///
/// Parameters:
/// [word]
///
/// Returns word with only alpha chars and dashes or empty string.
String keepCharAndDash(String word) {
  return word.contains(stringSanitizerRegEx)
      ? word.replaceAll(stringSanitizerRegEx, '')
      : word;
}

/// Separates dashed words
///
/// Parameters:
/// [word]
///
/// Returns a list of a word or words that may be empty,
///  or an empty list if [word.isEmpty].
List<String> stripDashedWord(String word) {
  // final words = word.split('-');

  return word.isNotEmpty ? word.split('-') : [];
}

/// Cleans up a sentence, removing all non alpha characters
///
/// Parameters: [sentence]
///
/// Returns a set of lowercased words with only alpha chars.
///
Set<String> cleanSentence(String sentence) {
  List<List<String>> words = [];

  for (var word in sentence.split(' ')) {
    final String charDash = keepCharAndDash(word).toLowerCase();
    final List<String> splitWords = stripDashedWord(charDash);

    if (splitWords.isNotEmpty) {
      words.add(splitWords);
    }
  }
  final set = words.expand((list) => list).toSet();
  set.remove('');
  return set;
}

bool isStopWord(word) {
  return stopWords.contains(word);
}
