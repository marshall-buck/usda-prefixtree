const keepTheseNutrients = [1003, 1004, 1005, 1008, 1079, 1258, 2000];

/// DO NOT DELTE these variables, altjough they might not ne used
/// now, they can be used at any time in the future.
const pathToFiles = 'lib/db';
const fileNameOriginalDBFile = 'original_usda.json';
const fileNameDuplicatePhrases = 'duplicate_phrases.json';
const fileNameOriginalDescriptions = 'original_descriprions.txt';
const fileNameFinalDescriptions = 'final_descriprions.txt';
const fileNameAutocompleteWordIndex = 'autocomplete_word_index.json';
const fileNameAutocompleteWordIndexKeys = 'autocomplete_word_index_keys.txt';
const fileNameAutocompleteHash = 'autocomplete_hash.json';
const fileNameFoodsDatabase = 'foods_db.json';
const fileNameNutrientsCsv = 'nutrient.csv';
const fileNameNutrientsMap = 'nutrient_map.json';

const unwantedPhrases = [
  "(Includes foods for USDA's Food Distribution Program)",
  "separable lean and fat, ",
  "separable lean only, "
];

const excludedCategories = ["Restaurant Foods", "Fast Foods", "Beverages"];

const List<String> stopWords = [
  "about",
  "above",
  "added",
  "after",
  "again",
  "against",
  "all",
  "am",
  "an",
  "and",
  "are",
  "as",
  "at",
  "be",
  "because",
  "been",
  "before",
  "being",
  "below",
  "between",
  "both",
  "but",
  "by",
  "can",
  "could",
  "did",
  "do",
  "does",
  "doing",
  "down",
  "during",
  "each",
  "few",
  "for",
  "from",
  "had",
  "has",
  "have",
  "having",
  "how",
  "if",
  "in",
  "into",
  "is",
  "it",
  "its",
  "just",
  "made",
  "more",
  "most",
  "not",
  "now",
  "of",
  "off",
  "on",
  "once",
  "only",
  "or",
  "other",
  "our",
  "ours",
  "out",
  "over",
  "own",
  "same",
  "she",
  "should",
  "so",
  "some",
  "such",
  "than",
  "that",
  "the",
  "their",
  "them",
  "then",
  "there",
  "these",
  "they",
  "this",
  "those",
  "through",
  "to",
  "too",
  "trimmed",
  "under",
  "until",
  "up",
  "very",
  "was",
  "we",
  "were",
  "what",
  "when",
  "where",
  "which",
  "while",
  "who",
  "will",
  "with",
  "without",
  "you",
  "your"
];
