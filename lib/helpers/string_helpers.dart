import 'package:usda_db_creation/helpers/stop_words.dart';

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
  List<List<String>> words = [];

  for (var word in sentence.split(' ')) {
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

/// Returns list of indexes where spaces are located in a string.
List<int> findAllSpacesInString(final String sentence) {
  List<int> indexesOfSpaces = [];
  if (sentence.isEmpty) return [];
  for (var i = 0; i < sentence.length; i++) {
    if (sentence[i] == " ") {
      if (i != sentence.length - 1) indexesOfSpaces.add(i);
    }
  }
  return indexesOfSpaces;
}

List<String?> separateIntoPhrasesWithMinimumLength({
  required final String sentence,
  required final int minPhraseLength,
}) {
  final Set<String> listOfPhrases = {};

  List<int> spacesList = findAllSpacesInString(sentence);

  spacesList.insert(0, -1);

  final int sentenceLength = sentence.length;
  if (spacesList.isEmpty) return [sentence.substring(0, sentenceLength)];
  if (sentenceLength < minPhraseLength) return listOfPhrases.toList();

  if (sentenceLength == minPhraseLength) {
    return [sentence];
  }

  for (int i = 0; i < spacesList.length; i++) {
    int currentSpace = spacesList[i];
    if (currentSpace + minPhraseLength > sentenceLength) break;
    int nextSpace = spacesList.firstWhere(
        (final element) => element >= currentSpace + minPhraseLength,
        orElse: () => sentenceLength);

    int subStringEndExclusive = i == 0 ? nextSpace + 1 : nextSpace;

    if (i == 0 && nextSpace != sentenceLength) {
      subStringEndExclusive = nextSpace + 1;
    } else {
      subStringEndExclusive = nextSpace;
    }

    assert(subStringEndExclusive <= sentenceLength);
    listOfPhrases
        .add(sentence.substring(currentSpace + 1, subStringEndExclusive));
    listOfPhrases.add(sentence.substring(currentSpace + 1, sentenceLength));
  }

  return listOfPhrases.toList();
}
