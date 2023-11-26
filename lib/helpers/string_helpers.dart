import 'package:usda_db_creation/helpers/stop_words.dart';

// Removes all non-alpha except dashes and parentheses,
//and numbers followed by a % See notes at bottom a file
String removeUnwantedChars(String word) {
  // Regex to remove unwanted characters

  final stringSanitizerRegEx = RegExp(r"[^\w()%\-]|(\d+%)");

  return word.replaceAllMapped(
      stringSanitizerRegEx, (match) => match.group(1) ?? '');
}

/// Separates dashed words.
///
/// Parameters:
/// [word]
///
/// Returns a list of a word(s), list may be empty and may contain empty strings.
List<String> stripDashedAndParenthesisWord(String word) {
  if (word.contains('-')) return word.split('-');
  if (word.startsWith('(') && word.endsWith(')')) {
    final trimmed = word.substring(1, word.length - 1);
    return [trimmed];
  }
  if (word.contains('(')) return word.split('(');
  if (word.contains(')')) return word.split(')');

  return word.isNotEmpty ? [word] : [];
}

/// Cleans up a sentence, removing all non alpha characters
///
/// Parameters: [sentence]
///
/// Returns a set of lowercased words with only alpha chars.

Set<String> cleanSentence(String sentence) {
  List<List<String>> words = [];

  for (var word in sentence.split(' ')) {
    final String charDash = removeUnwantedChars(word).toLowerCase();
    final List<String> splitWords = stripDashedAndParenthesisWord(charDash);

    if (splitWords.isNotEmpty) {
      words.add(splitWords);
    }
  }
  final wordsSet = words.expand((list) => list).toSet();
  wordsSet.remove('');
  return wordsSet;
}

bool isStopWord(word) {
  return stopWords.contains(word);
}

List<String> findRepeatedPhrases(List<String> strings, int phraseLength) {
  Map<String, int> phraseCounts = {};

  for (String sentence in strings) {
    if (sentence.length >= phraseLength) {
      for (int i = 0; i <= sentence.length - phraseLength; i++) {
        String phrase = sentence.substring(i, i + phraseLength);
        if (!(phrase.startsWith(' ') || phrase.endsWith(' '))) {
          phraseCounts[phrase] = (phraseCounts[phrase] ?? 0) + 1;
        }
      }
    }
  }

  List<String> result = [];
  phraseCounts.forEach((phrase, count) {
    if (count > 1) {
      result.add(phrase);
    }
  });

  return result;
}





// Here's the breakdown of the components in this regular expression:

// 1.  [^...]: This is a character class negation. It matches any character that
//      is not contained within the square brackets.

// 2.  \w: This is a shorthand character class for word characters.
//        It matches any alphabetic character (a-z, A-Z), digit (0-9), or underscore (_).

// 3.  (): These parentheses are treated as literal characters and match themselves.

// 4.  %: This is also treated as a literal character and matches itself.

// 5.  \-: This is a hyphen inside a character class, and it's also treated as
//      a literal character to match a hyphen.

// 6.  |: This is an alternation operator, which means "or." It allows the regex
//        to match either the pattern on its left or the pattern on its right.

// 7.  \d+%): This is a capturing group that matches one or more digits followed
//        by a '%' sign. It captures this sequence of digits and '%'
//        so that it can be preserved in the replacement.

// Putting it all together, this regex pattern matches:
//
// Any character that is not a word character (letters, digits, underscore),
//  a parenthesis (either '(', ')'), a percent symbol (%), or a hyphen (-).

// Or, it matches a sequence of one or more digits followed by a '%'
//    ign and captures it in a group.

// In the replaceAllMapped function, we use this regex pattern to find and
//replace the unwanted characters with an empty string ('') while preserving
//  the captured digits and '%' sign, effectively keeping numbers followed by
//  '%' while removing other unwanted characters.
