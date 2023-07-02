import 'dart:convert';
import 'dart:io';

import 'package:usda_db_creation/helpers/file_helpers.dart';

import 'prefix_node.dart';

const wordIndexPath = './lib/db/word_index_db.json';
const testWordList = ['ali', 'alice', 'anna', 'elias', 'eliza'];

void main() async {
  // await createMainPrefixTree();
  final tree = await createTestingPrefixTree();
  print(tree.searchByPrefix('elia'));
}

class PrefixTree {
  PTNode? root;

  /// Adds a node to the prefix tree.
  ///
  /// Parameters:
  /// - [word] The word to be added.
  /// - [pos] The position of the current character in the word.
  /// - [node] The node to be added. If null, a new node will be created.
  ///
  /// Returns the added node.
  static PTNode? _addNode(String word, int pos, PTNode? node) {
    node ??= PTNode(key: word[pos]);

    if (word.codeUnitAt(pos) < node.key!.codeUnitAt(0)) {
      node.left = _addNode(word, pos, node.left);
    } else if (word.codeUnitAt(pos) > node.key!.codeUnitAt(0)) {
      node.right = _addNode(word, pos, node.right);
    } else {
      if (pos + 1 == word.length) {
        node.isEnd = true;
      } else {
        node.middle = _addNode(word, pos + 1, node.middle);
      }
    }

    return node;
  }

  /// Adds a word to the prefix tree.
  ///
  /// Parameters:
  /// - [word] The word to be added.
  void _addWord(String word) {
    root = _addNode(word, 0, root);
  }

  /// Inserts a list of words into the prefix tree.
  ///
  /// Parameters:
  /// - [wordList] The list of words to be inserted.
  void insertWordList(List<String> wordList) {
    for (final word in wordList) {
      _addWord(word);
    }
  }

  /// Converts the prefix tree to a JSON representation.
  ///
  /// Returns a JSON representation of the prefix tree.
  Map<String, dynamic> toJson() {
    return {'root': root?.toJson()};
  }

  /// Creates a `PrefixTree` object from a JSON file.
  ///
  /// Parameters:
  /// - [jsonFile]: The JSON file to read and parse.
  ///
  /// Returns a `PrefixTree` object created from the JSON data.
  PrefixTree fromJsonFile(File jsonFile) {
    String jsonString = jsonFile.readAsStringSync();
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    PrefixTree prefixTree = PrefixTree();
    prefixTree.root = PTNode.fromJson(jsonMap['root']);
    return prefixTree;
  }

  /// Searches for all words starting with a given prefix.
  ///
  /// Parameters:
  /// - [prefix]: The prefix to search for.
  ///
  /// Returns a list of strings that start with the prefix. If no matches are found, an empty list is returned.
  List<String> searchByPrefix(String prefix) {
    PTNode? node = findNode(prefix);
    List<String> result = [];

    if (node != null) {
      if (node.isEnd == true) {
        // If the prefix itself is a word, add it to the result
        result.add(prefix);
      }

      // Collect all words starting from the node's subtree
      _collectWords(node.middle, prefix, result);
    }

    return result;
  }

  /// Recursively collects all words from a given node and its subtree.
  ///
  /// Parameters:
  /// - [node]: The current node to collect words from.
  /// - [prefix]: The prefix used for searching.
  /// - [result]: The list to collect the matched words.
  static void _collectWords(PTNode? node, String prefix, List<String> result) {
    if (node == null) {
      return;
    }

    // Recursively collect words from the left, middle, and right nodes
    _collectWords(node.left, prefix, result);

    // If the current node is an end node, add it to the result list
    if (node.isEnd == true) {
      result.add(prefix + node.key!);
    }

    _collectWords(node.middle, prefix + node.key!, result);
    _collectWords(node.right, prefix, result);
  }

  /// Finds the node that corresponds to the given prefix.
  ///
  /// Parameters:
  /// - [prefix]: The prefix to search for.
  ///
  /// Returns the node that corresponds to the prefix, or null if not found.
  PTNode? findNode(String prefix) {
    PTNode? node = root;
    int pos = 0;

    while (node != null) {
      if (prefix.codeUnitAt(pos) < node.key!.codeUnitAt(0)) {
        node = node.left;
      } else if (prefix.codeUnitAt(pos) > node.key!.codeUnitAt(0)) {
        node = node.right;
      } else {
        pos++;

        if (pos == prefix.length) {
          // Reached the end of the prefix
          return node;
        }

        node = node.middle;
      }
    }

    return null;
  }

  @override
  String toString() {
    return '$root';
  }
}

/// FOR INITIAL POPULATION AND TESTING

Future<void> createMainPrefixTree() async {
  final x = PrefixTree();
  final indexDb = await readJsonFile(wordIndexPath);
  final wordList = indexDb.keys.toList() as List<String>;

  int middleIndex = (wordList.length / 2).round();
  String removedElement = wordList.removeAt(middleIndex);
  wordList.insert(0, removedElement);

  // final wordList = ['ali', 'alice', 'anna', 'elias', 'eliza'];

  x.insertWordList(wordList);

  writeJsonFile('lib/db/prefix_tree.json', x.toJson());
}

Future<PrefixTree> createTestingPrefixTree() async {
  final x = PrefixTree();
  // final indexDb = await readJsonFile(wordIndexPath);
  // final wordList = indexDb.keys.toList() as List<String>;

  // int middleIndex = (wordList.length / 2).round();
  // String removedElement = wordList.removeAt(middleIndex);
  // wordList.insert(0, removedElement);

  // final wordList = ['ali', 'alice', 'anna', 'elias', 'eliza'];

  x.insertWordList(testWordList);

  writeJsonFile('lib/db/test_prefix_tree.json', x.toJson());
  return x;
}
