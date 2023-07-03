import 'package:test/test.dart';
import 'package:usda_db_creation/prefix_node.dart';
import 'dart:convert';
import 'dart:io';

import 'package:usda_db_creation/prefix_tree.dart';

void main() {
  group('insertWordList', () {
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
    });
  });

  group('toJson', () {
    test('Converts to JSON correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      Map<String, dynamic> json = prefixTree.toJson();
      String jsonString = jsonEncode(json);

      expect(jsonString,
          '{"root":{"key":"a","isEnd":false,"left":null,"middle":{"key":"l","isEnd":false,"left":null,"middle":{"key":"i","isEnd":true,"left":null,"middle":{"key":"c","isEnd":false,"left":null,"middle":{"key":"e","isEnd":true,"left":null,"middle":null,"right":null},"right":null},"right":null},"right":{"key":"n","isEnd":false,"left":null,"middle":{"key":"n","isEnd":false,"left":null,"middle":{"key":"a","isEnd":true,"left":null,"middle":null,"right":null},"right":null},"right":null}},"right":{"key":"e","isEnd":false,"left":null,"middle":{"key":"l","isEnd":false,"left":null,"middle":{"key":"i","isEnd":false,"left":null,"middle":{"key":"a","isEnd":false,"left":null,"middle":{"key":"s","isEnd":true,"left":null,"middle":null,"right":null},"right":{"key":"z","isEnd":false,"left":null,"middle":{"key":"a","isEnd":true,"left":null,"middle":null,"right":null},"right":null}},"right":null},"right":null},"right":null}}}');
    });
  });
  group('fromJsonFile', () {
    test('Creates PrefixTree object from JSON file', () async {
      File jsonFile = File('./test/data/test_prefix_tree.json');

      PrefixTree prefixTree = PrefixTree().fromJsonFile(jsonFile);

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
    });
  });

  group('searchByPrefix', () {
    test('Searches words by prefix correctly', () {
      PrefixTree prefixTree = PrefixTree();
      prefixTree.insertWordList(['ali', 'alice', 'anna', 'elias', 'eliza']);

      expect(prefixTree.searchByPrefix('al'), ['ali', 'alice']);
      expect(prefixTree.searchByPrefix('el'), ['elias', 'eliza']);
      expect(prefixTree.searchByPrefix('elis'), []);
      expect(prefixTree.searchByPrefix('anna'), ['anna']);
      expect(prefixTree.searchByPrefix('z'), []);
    });
  });

  group('findNode', () {
    test('Finds node for prefix correctly', () {
      File jsonFile = File('./test/data/test_prefix_tree.json');

      PrefixTree prefixTree = PrefixTree().fromJsonFile(jsonFile);

      PTNode? node1 = prefixTree.findNode('al');
      expect(node1!.key, 'l');
      expect(node1.middle!.key, 'i');
      expect(node1.middle!.isEnd, true);

      PTNode? node2 = prefixTree.findNode('el');
      expect(node2!.key, 'l');
      expect(node2.middle!.key, 'i');
      expect(node2.middle!.middle!.key, 'a');
      expect(node2.middle!.middle!.middle!.isEnd, true);

      PTNode? node3 = prefixTree.findNode('elis');
      expect(node3, isNull);

      PTNode? node4 = prefixTree.findNode('anna');
      expect(node4!.isEnd, true);

      PTNode? node5 = prefixTree.findNode('z');
      expect(node5, null);
    });
  });
}
