import 'dart:convert';
import 'dart:io';

import 'package:usda_db_creation/helpers/file_helpers.dart';

import 'prefix_node.dart';

void main() async {
  final x = PrefixTree();
  // final indexDb = await readJsonFile("lib/index_db.json");
  // final wordList = indexDb.keys.toList() as List<String>;

  final wordList = ['ali', 'alice', 'anna', 'elias', 'eliza'];
  // final wordList = ['ali', 'alice', 'anna', 'elias', 'eliza'];
  print(wordList);

  x.insertWordList(wordList);

  print(x);

  writeJsonFile('lib/db/prefix_tree.json', x.toJson());
//   print(x.search('app'));
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
  PTNode? addNode(String word, int pos, PTNode? node) {
    node ??= PTNode(key: word[pos]);

    if (word.codeUnitAt(pos) < node.key!.codeUnitAt(0)) {
      node.left = addNode(word, pos, node.left);
    } else if (word.codeUnitAt(pos) > node.key!.codeUnitAt(0)) {
      node.right = addNode(word, pos, node.right);
    } else {
      if (pos + 1 == word.length) {
        node.isEnd = true;
      } else {
        node.middle = addNode(word, pos + 1, node.middle);
      }
    }

    return node;
  }

  /// Adds a word to the prefix tree.
  ///
  /// Parameters:
  /// - [word] The word to be added.
  void addWord(String word) {
    root = addNode(word, 0, root);
  }

  /// Inserts a list of words into the prefix tree.
  ///
  /// Parameters:
  /// - [wordList] The list of words to be inserted.
  void insertWordList(List<String> wordList) {
    for (final word in wordList) {
      addWord(word);
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
  static PrefixTree fromJsonFile(File jsonFile) {
    String jsonString = jsonFile.readAsStringSync();
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    PrefixTree prefixTree = PrefixTree();
    prefixTree.root = PTNode.fromJson(jsonMap['root']);
    return prefixTree;
  }

  @override
  String toString() {
    return '$root';
  }

  // bool contains(String s) {
  //   if (s == null || s.isEmpty) throw ArgumentError();

  //   int pos = 0;
  //   Node? node = root;
  //   while (node != null) {
  //     int cmp = s.codeUnitAt(pos) - node.key.codeUnitAt(0);
  //     if (s.codeUnitAt(pos) < node.key.codeUnitAt(0)) {
  //       node = node.left;
  //     } else if (s.codeUnitAt(pos) > node.key.codeUnitAt(0)) {
  //       node = node.right;
  //     } else {
  //       if (++pos == s.length) return node.isEnd;
  //       node = node.middle;
  //     }
  //   }

  //   return false;
  // }
}
