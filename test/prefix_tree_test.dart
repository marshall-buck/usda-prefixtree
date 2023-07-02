import 'package:test/test.dart';
import 'package:usda_db_creation/prefix_node.dart';
import 'dart:convert';
import 'dart:io';

import 'package:usda_db_creation/prefix_tree.dart';

void main() {
  group('PrefixTree', () {
    test('Inserts words correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      expect(prefixTree.root!.key, 'a');
      expect(prefixTree.root!.middle!.key, 'l');
      expect(prefixTree.root!.middle!.right!.key, 'n');
      expect(prefixTree.root!.middle!.right!.middle!.key, 'n');
      expect(prefixTree.root!.middle!.right!.middle!.middle!.key, 'a');
      expect(prefixTree.root!.middle!.right!.middle!.middle!.isEnd, true);
      expect(prefixTree.root!.middle!.middle!.key, 'i');
      expect(prefixTree.root!.middle!.middle!.isEnd, true);
      expect(prefixTree.root!.middle!.middle!.middle!.key, 'c');
      expect(prefixTree.root!.middle!.middle!.middle!.middle!.key, 'e');
      expect(prefixTree.root!.middle!.middle!.middle!.middle!.isEnd, true);

      expect(prefixTree.root!.right!.key, 'e');
      expect(prefixTree.root!.right!.middle!.key, 'l');
      expect(prefixTree.root!.right!.middle!.middle!.key, 'i');
      expect(prefixTree.root!.right!.middle!.middle!.middle!.key, 'a');
      expect(prefixTree.root!.right!.middle!.middle!.middle!.middle!.key, 's');
      expect(
          prefixTree.root!.right!.middle!.middle!.middle!.middle!.isEnd, true);

      expect(prefixTree.root!.right!.middle!.middle!.middle!.right!.key, 'z');
      expect(prefixTree.root!.right!.middle!.middle!.middle!.right!.middle!.key,
          'a');
      expect(
          prefixTree.root!.right!.middle!.middle!.middle!.right!.middle!.isEnd,
          true);

      // expect(prefixTree.root!.middle!.middle!.right!.key, 'n');
      // expect(prefixTree.root!.middle!.middle!.right!.right!.key, 'n');
      // expect(prefixTree.root!.middle!.middle!.right!.right!.isEnd, true);

      // expect(prefixTree.root!.right!.key, 'e');
      // expect(prefixTree.root!.right!.middle!.key, 'l');
      // expect(prefixTree.root!.right!.middle!.middle!.key, 'i');
      // expect(prefixTree.root!.right!.middle!.middle!.middle!.key, 'a');
      // expect(prefixTree.root!.right!.middle!.middle!.middle!.isEnd, true);

      // expect(prefixTree.root!.right!.middle!.right!.key, 'z');
      // expect(prefixTree.root!.right!.middle!.right!.middle!.key, 'a');
      // expect(prefixTree.root!.right!.middle!.right!.middle!.isEnd, true);
    });

    test('Converts to JSON correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      Map<String, dynamic> json = prefixTree.toJson();
      String jsonString = jsonEncode(json);

      expect(jsonString,
          '{"root":{"key":"a","middle":{"key":"l","middle":{"key":"i","isEnd":true},"right":{"key":"c","middle":{"key":"e","isEnd":true}},"right":{"key":"n","right":{"key":"n","isEnd":true}}}},"right":{"key":"e","middle":{"key":"l","middle":{"key":"i","middle":{"key":"a","isEnd":true}},"right":{"key":"z","middle":{"key":"a","isEnd":true}}}}}}}');
    });

    test('Creates PrefixTree object from JSON file', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      // Create a temporary JSON file
      File jsonFile = File('temp.json');
      jsonFile.writeAsStringSync(
          '{"root":{"key":"a","middle":{"key":"l","middle":{"key":"i","isEnd":true},"right":{"key":"c","middle":{"key":"e","isEnd":true}},"right":{"key":"n","right":{"key":"n","isEnd":true}}}},"right":{"key":"e","middle":{"key":"l","middle":{"key":"i","middle":{"key":"a","isEnd":true}},"right":{"key":"z","middle":{"key":"a","isEnd":true}}}}}}}');

      PrefixTree loadedPrefixTree = PrefixTree().fromJsonFile(jsonFile);

      expect(loadedPrefixTree.root!.key, 'a');
      expect(loadedPrefixTree.root!.middle!.key, 'l');
      expect(loadedPrefixTree.root!.middle!.middle!.key, 'i');
      expect(loadedPrefixTree.root!.middle!.middle!.isEnd, true);

      expect(loadedPrefixTree.root!.middle!.right!.key, 'c');
      expect(loadedPrefixTree.root!.middle!.right!.middle!.key, 'e');
      expect(loadedPrefixTree.root!.middle!.right!.middle!.isEnd, true);

      expect(loadedPrefixTree.root!.middle!.middle!.right!.key, 'n');
      expect(loadedPrefixTree.root!.middle!.middle!.right!.right!.key, 'n');
      expect(loadedPrefixTree.root!.middle!.middle!.right!.right!.isEnd, true);

      expect(loadedPrefixTree.root!.right!.key, 'e');
      expect(loadedPrefixTree.root!.right!.middle!.key, 'l');
      expect(loadedPrefixTree.root!.right!.middle!.middle!.key, 'i');
      expect(loadedPrefixTree.root!.right!.middle!.middle!.middle!.key, 'a');
      expect(loadedPrefixTree.root!.right!.middle!.middle!.middle!.isEnd, true);

      expect(loadedPrefixTree.root!.right!.middle!.right!.key, 'z');
      expect(loadedPrefixTree.root!.right!.middle!.right!.middle!.key, 'a');
      expect(loadedPrefixTree.root!.right!.middle!.right!.middle!.isEnd, true);

      // Delete the temporary JSON file
      jsonFile.deleteSync();
    });

    test('Searches words by prefix correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      expect(prefixTree.searchByPrefix('al'), ['ali', 'alice', 'anna']);
      expect(prefixTree.searchByPrefix('el'), ['elias', 'eliza']);
      expect(prefixTree.searchByPrefix('elis'), ['elisa']);
      expect(prefixTree.searchByPrefix('anna'), []);
      expect(prefixTree.searchByPrefix('z'), []);
    });

    test('Finds node for prefix correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      PTNode? node1 = prefixTree.findNode('al');
      expect(node1!.key, 'l');
      expect(node1.middle!.key, 'i');
      expect(node1.middle!.isEnd, true);

      PTNode? node2 = prefixTree.findNode('el');
      expect(node2!.key, 'l');
      expect(node2.middle!.key, 'i');
      expect(node2.middle!.middle!.key, 'a');
      expect(node2.middle!.middle!.isEnd, true);

      PTNode? node3 = prefixTree.findNode('elis');
      expect(node3!.key, 's');
      expect(node3.isEnd, true);

      PTNode? node4 = prefixTree.findNode('anna');
      expect(node4, null);

      PTNode? node5 = prefixTree.findNode('z');
      expect(node5, null);
    });
  });
}
